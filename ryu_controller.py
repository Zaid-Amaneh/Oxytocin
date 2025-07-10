from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER, DEAD_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet, ethernet, arp, ipv4, icmp, udp, dhcp, ether_types, lldp
from ryu.lib import addrconv, hub
import struct
from ipaddress import ip_address, ip_network
import time
import logging
import networkx as nx
import random

class MultiPathController(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    # DHCP Constants and Option Tags (as in original)
    DHCP_DISCOVER = 1
    DHCP_OFFER = 2
    DHCP_REQUEST = 3
    DHCP_ACK = 5
    DHCP_MESSAGE_TYPE = 53
    DHCP_SERVER_ID = 54
    DHCP_LEASE_TIME = 51
    DHCP_SUBNET_MASK = 1
    DHCP_ROUTER = 3
    DHCP_DNS_SERVER = 6
    DHCP_REQUESTED_IP = 50
    DHCP_END = 255

    def __init__(self, *args, **kwargs):
        super(MultiPathController, self).__init__(*args, **kwargs)

        # --- Logging Setup ---
        self.logger.setLevel(logging.INFO)

        # --- Topology Discovery ---
        self.net = nx.DiGraph()
        self.switches = {}  # dpid -> datapath
        self.mac_to_port = {}  # dpid -> {mac -> port}
        self.lldp_delay = 5  # seconds
        self.discovery_thread = hub.spawn(self._lldp_loop)

        # --- L3 Routing ---
        self.router_mac = 'aa:bb:cc:dd:ee:ff'
        self.arp_table = {}  # ip -> mac
        self.pending_arp_packets = {}  # ip -> list of buffered packets

        # --- DHCP Server ---
        self.server_ip = '192.168.196.144' # A virtual IP for the DHCP server
        self.subnets = {
            's2': {
                'network': '192.168.4.0/25',
                'pool_range': ['192.168.4.4', '192.168.4.126'],
                'router': '192.168.4.1',
                'subnet_mask': '255.255.255.128',
            },
            's3': {
                'network': '192.168.0.0/26',
                'pool_range': ['192.168.0.4', '192.168.0.62'],
                'router': '192.168.0.1',
                'subnet_mask': '255.255.255.192',
            },
            's4': {
                'network': '192.168.0.64/22',
                'pool_range': ['192.168.0.70', '192.168.3.254'],
                'router': '192.168.0.65',
                'subnet_mask': '255.255.252.0',
            }
        }
        # Common settings for all subnets
        for name, config in self.subnets.items():
            config['dns_server'] = '8.8.8.8'
            config['lease_time'] = 86400
            start_ip = ip_address(config['pool_range'][0])
            end_ip = ip_address(config['pool_range'][1])
            config['pool'] = [str(ip) for ip in range(int(start_ip), int(end_ip) + 1)]
        
        # Make s5, s6, s7 use the same config as s4
        self.subnets['s5'] = self.subnets['s4']
        self.subnets['s6'] = self.subnets['s4']
        self.subnets['s7'] = self.subnets['s4']
        
        self.leases = {}  # mac -> {ip, subnet_name, lease_end}

    # --- Utility Methods ---
    def get_subnet_name(self, ip_str):
        ip = ip_address(ip_str)
        for name, subnet in self.subnets.items():
            if ip in ip_network(subnet['network'], strict=False):
                return name
        return None

    def get_host_location(self, mac):
        for dpid, mac_table in self.mac_to_port.items():
            if mac in mac_table:
                return (dpid, mac_table[mac])
        return None

    def add_flow(self, datapath, priority, match, actions):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        inst = [parser.OFPInstructionActions(ofproto.OFPIT_APPLY_ACTIONS, actions)]
        mod = parser.OFPFlowMod(datapath=datapath, priority=priority,
                                match=match, instructions=inst)
        datapath.send_msg(mod)

    def send_packet(self, datapath, port, data):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        actions = [parser.OFPActionOutput(port)]
        out = parser.OFPPacketOut(
            datapath=datapath,
            buffer_id=ofproto.OFP_NO_BUFFER,
            in_port=ofproto.OFPP_CONTROLLER,
            actions=actions,
            data=data
        )
        datapath.send_msg(out)

    # --- Topology Discovery (LLDP) ---
    def _lldp_loop(self):
        while True:
            for datapath in self.switches.values():
                self._send_lldp_packet(datapath)
            hub.sleep(self.lldp_delay)

    def _send_lldp_packet(self, datapath):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        for port_no in range(1, ofproto.OFPP_MAX + 1):
            try:
                port_features = datapath.ports[port_no]
                if port_features.state & 1: # Link Down
                    continue

                pkt = packet.Packet()
                pkt.add_protocol(ethernet.ethernet(
                    ethertype=ether_types.ETH_TYPE_LLDP,
                    src=datapath.ports[port_no].hw_addr,
                    dst=lldp.LLDP_MAC_NEAREST_BRIDGE))
                
                tlv_chassis_id = lldp.ChassisID(
                    subtype=lldp.ChassisID.SUB_LOCALLY_ASSIGNED,
                    chassis_id=str(datapath.id).encode('utf-8'))
                tlv_port_id = lldp.PortID(
                    subtype=lldp.PortID.SUB_PORT_COMPONENT,
                    port_id=str(port_no).encode('utf-8'))
                tlv_ttl = lldp.TTL(ttl=120)
                tlv_end = lldp.End()
                
                pkt.add_protocol(lldp.lldp(
                    tlvs=[tlv_chassis_id, tlv_port_id, tlv_ttl, tlv_end]))
                pkt.serialize()
                
                self.send_packet(datapath, port_no, pkt.data)
            except KeyError:
                continue

    def _handle_lldp(self, datapath, port, pkt):
        lldp_pkt = pkt.get_protocol(lldp.lldp)
        if not lldp_pkt:
            return
            
        src_dpid = int(lldp_pkt.tlvs[0].chassis_id)
        src_port = int(lldp_pkt.tlvs[1].port_id)
        dst_dpid = datapath.id
        dst_port = port

        if src_dpid not in self.net:
            self.net.add_node(src_dpid)
        if dst_dpid not in self.net:
            self.net.add_node(dst_dpid)
            
        # The port attribute on the edge (u,v) is the port on u that leads to v
        self.net.add_edge(src_dpid, dst_dpid, port=src_port)
        self.net.add_edge(dst_dpid, src_dpid, port=dst_port)

    # --- Switch Connection Handlers ---
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        # Install table-miss flow entry
        match = parser.OFPMatch()
        actions = [parser.OFPActionOutput(ofproto.OFPP_CONTROLLER,
                                          ofproto.OFPCML_NO_BUFFER)]
        self.add_flow(datapath, 0, match, actions)
        self.logger.info(f"[SWITCH] Registered switch: DPID={datapath.id}")
        self.switches[datapath.id] = datapath
        self.mac_to_port.setdefault(datapath.id, {})

    @set_ev_cls(ofp_event.EventOFPStateChange, [MAIN_DISPATCHER, DEAD_DISPATCHER])
    def _state_change_handler(self, ev):
        datapath = ev.datapath
        if ev.state == DEAD_DISPATCHER:
            if datapath.id in self.switches:
                del self.switches[datapath.id]
                if datapath.id in self.net:
                    self.net.remove_node(datapath.id)
                self.logger.warning(f"[SWITCH] Switch disconnected: DPID={datapath.id}")
                
    # --- Main Packet Handler ---
    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
        msg = ev.msg
        datapath = msg.datapath
        in_port = msg.match['in_port']
        pkt = packet.Packet(msg.data)
        eth_pkt = pkt.get_protocol(ethernet.ethernet)

        if not eth_pkt or eth_pkt.dst.startswith('01:00:5e'): # Ignore multicast
            return

        if eth_pkt.ethertype == ether_types.ETH_TYPE_LLDP:
            self._handle_lldp(datapath, in_port, pkt)
            return
            
        if eth_pkt.ethertype == ether_types.ETH_TYPE_IPV6:
            return

        # Learn source MAC address
        self.mac_to_port.setdefault(datapath.id, {})
        self.mac_to_port[datapath.id][eth_pkt.src] = in_port
        
        # Dispatch based on packet type
        if eth_pkt.ethertype == ether_types.ETH_TYPE_ARP:
            self._handle_arp(datapath, in_port, pkt)
        elif eth_pkt.ethertype == ether_types.ETH_TYPE_IP:
            self._handle_ip(datapath, in_port, pkt)
        else:
            # Fallback to L2 flooding for unknown types
            self._l2_flood(datapath, in_port, msg.data)

    # --- L2 Logic ---
    def _l2_flood(self, datapath, in_port, data):
        ofproto = datapath.ofproto
        actions = [datapath.ofproto_parser.OFPActionOutput(ofproto.OFPP_FLOOD)]
        self.send_packet(datapath, in_port, data)
        
    def _l2_forward(self, datapath, in_port, pkt):
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        dst_mac = eth_pkt.dst
        dpid = datapath.id
        
        location = self.get_host_location(dst_mac)
        if location and location[0] == dpid:
            # Destination is on the same switch
            out_port = location[1]
            actions = [datapath.ofproto_parser.OFPActionOutput(out_port)]
            match = datapath.ofproto_parser.OFPMatch(eth_dst=dst_mac)
            self.add_flow(datapath, 1, match, actions)
            self.send_packet(datapath, out_port, pkt.data)
        else:
            # Flood if destination is unknown on this switch
             self._l2_flood(datapath, in_port, pkt.data)

    # --- IP, ICMP, DHCP Handlers ---
    def _handle_ip(self, datapath, in_port, pkt):
        ip_pkt = pkt.get_protocol(ipv4.ipv4)

        # Handle DHCP
        if pkt.get_protocol(udp.udp) and pkt.get_protocol(dhcp.dhcp):
            self._handle_dhcp(datapath, in_port, pkt)
            return

        # Handle ICMP to router
        if ip_pkt.proto == ip_proto.IPPROTO_ICMP:
            icmp_pkt = pkt.get_protocol(icmp.icmp)
            if icmp_pkt.type == icmp.ICMP_ECHO_REQUEST:
                dst_subnet = self.get_subnet_name(ip_pkt.dst)
                if dst_subnet and ip_pkt.dst == self.subnets[dst_subnet]['router']:
                    self._handle_icmp_to_router(datapath, in_port, pkt)
                    return

        # Check if routing is needed
        src_subnet = self.get_subnet_name(ip_pkt.src)
        dst_subnet = self.get_subnet_name(ip_pkt.dst)
        
        if src_subnet and dst_subnet and src_subnet != dst_subnet:
            self._handle_l3_routing(datapath, in_port, pkt)
        else:
            self._l2_forward(datapath, in_port, pkt)
            
    def _handle_icmp_to_router(self, datapath, port, pkt):
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        ip_pkt = pkt.get_protocol(ipv4.ipv4)
        icmp_pkt = pkt.get_protocol(icmp.icmp)

        # Create ICMP Echo Reply
        reply_pkt = packet.Packet()
        reply_pkt.add_protocol(ethernet.ethernet(
            ethertype=ether_types.ETH_TYPE_IP,
            dst=eth_pkt.src,
            src=self.router_mac))
        reply_pkt.add_protocol(ipv4.ipv4(
            dst=ip_pkt.src,
            src=ip_pkt.dst,
            proto=ip_pkt.proto))
        reply_pkt.add_protocol(icmp.icmp(
            type_=icmp.ICMP_ECHO_REPLY,
            code=icmp.ICMP_ECHO_REPLY_CODE,
            csum=0,
            data=icmp_pkt.data))
        reply_pkt.serialize()

        self.send_packet(datapath, port, reply_pkt.data)
        self.logger.info(f"[ICMP] Replied to ping for router interface {ip_pkt.dst}")

    def _handle_dhcp(self, datapath, port, pkt):
        dhcp_pkt = pkt.get_protocol(dhcp.dhcp)
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        mac = eth_pkt.src
        switch_name = f's{datapath.id}'
        xid = dhcp_pkt.xid

        msg_type = dhcp_pkt.options.get_option(self.DHCP_MESSAGE_TYPE).value[0]
        
        subnet_info = self.subnets.get(switch_name)
        if not subnet_info:
            self.logger.warning(f"[DHCP] Request from unknown switch {switch_name}")
            return
        
        if msg_type == self.DHCP_DISCOVER:
            # Find available IP
            lease = self.leases.get(mac)
            ip_to_offer = lease['ip'] if lease else subnet_info['pool'].pop(0)
            if not ip_to_offer:
                self.logger.error(f"[DHCP] IP Pool for {switch_name} is empty!")
                return
            
            # Send DHCP Offer
            options = self._get_dhcp_options(self.DHCP_OFFER, subnet_info)
            reply_pkt = self._build_dhcp_packet(
                mac, ip_to_offer, xid, subnet_info, options)
            self.send_packet(datapath, port, reply_pkt.data)
            self.logger.info(f"[DHCP] Offered {ip_to_offer} to {mac} on {switch_name}")

        elif msg_type == self.DHCP_REQUEST:
            requested_ip = dhcp_pkt.options.get_option(self.DHCP_REQUESTED_IP)
            if not requested_ip: return
            requested_ip = addrconv.ipv4.bin_to_text(requested_ip.value)
            
            # Commit lease
            self.leases[mac] = {
                'ip': requested_ip,
                'subnet_name': switch_name,
                'lease_end': time.time() + subnet_info['lease_time']
            }
            self.arp_table[requested_ip] = mac
            
            # Send DHCP ACK
            options = self._get_dhcp_options(self.DHCP_ACK, subnet_info)
            reply_pkt = self._build_dhcp_packet(
                mac, requested_ip, xid, subnet_info, options)
            self.send_packet(datapath, port, reply_pkt.data)
            self.logger.info(f"[DHCP] ACK for {requested_ip} sent to {mac}")
            
    def _get_dhcp_options(self, msg_type, subnet_info):
        return [
            dhcp.option(tag=self.DHCP_MESSAGE_TYPE, value=bytes([msg_type])),
            dhcp.option(tag=self.DHCP_SERVER_ID, value=addrconv.ipv4.text_to_bin(self.server_ip)),
            dhcp.option(tag=self.DHCP_LEASE_TIME, value=struct.pack('!I', subnet_info['lease_time'])),
            dhcp.option(tag=self.DHCP_SUBNET_MASK, value=addrconv.ipv4.text_to_bin(subnet_info['subnet_mask'])),
            dhcp.option(tag=self.DHCP_ROUTER, value=addrconv.ipv4.text_to_bin(subnet_info['router'])),
            dhcp.option(tag=self.DHCP_DNS_SERVER, value=addrconv.ipv4.text_to_bin(subnet_info['dns_server'])),
            dhcp.option(tag=self.DHCP_END, value=b'')
        ]

    def _build_dhcp_packet(self, mac, ip, xid, subnet_info, options):
        pkt = packet.Packet()
        pkt.add_protocol(ethernet.ethernet(
            ethertype=ether_types.ETH_TYPE_IP, dst='ff:ff:ff:ff:ff:ff', src=self.router_mac))
        pkt.add_protocol(ipv4.ipv4(
            dst='255.255.255.255', src=self.server_ip, proto=17))
        pkt.add_protocol(udp.udp(src_port=67, dst_port=68))
        pkt.add_protocol(dhcp.dhcp(
            op=2, chaddr=addrconv.mac.text_to_bin(mac), yiaddr=ip, 
            siaddr=self.server_ip, xid=xid, options=dhcp.options(option_list=options)))
        pkt.serialize()
        return pkt

    # --- ARP Logic ---
    def _handle_arp(self, datapath, port, pkt):
        arp_pkt = pkt.get_protocol(arp.arp)
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        
        # Learn ARP mapping
        self.arp_table[arp_pkt.src_ip] = arp_pkt.src_mac
        
        # If this resolved a pending packet, forward it
        if arp_pkt.src_ip in self.pending_arp_packets:
            for buffered_pkt in self.pending_arp_packets[arp_pkt.src_ip]:
                self._handle_l3_routing(datapath, port, buffered_pkt)
            del self.pending_arp_packets[arp_pkt.src_ip]

        if arp_pkt.opcode == arp.ARP_REQUEST:
            # Check if we should reply (Proxy ARP or for Router)
            target_ip = arp_pkt.dst_ip
            target_mac = self.arp_table.get(target_ip)
            
            src_subnet = self.get_subnet_name(arp_pkt.src_ip)
            dst_subnet = self.get_subnet_name(target_ip)

            should_reply = False
            if target_mac:
                should_reply = True # We know the MAC
            elif dst_subnet and src_subnet != dst_subnet:
                should_reply = True # Proxy ARP for different subnet
                target_mac = self.router_mac # Reply with our MAC
            elif dst_subnet and target_ip == self.subnets[dst_subnet]['router']:
                should_reply = True # ARP for router interface
                target_mac = self.router_mac

            if should_reply:
                reply_pkt = packet.Packet()
                reply_pkt.add_protocol(ethernet.ethernet(
                    dst=eth_pkt.src, src=target_mac, ethertype=ether_types.ETH_TYPE_ARP))
                reply_pkt.add_protocol(arp.arp(
                    opcode=arp.ARP_REPLY,
                    src_mac=target_mac, src_ip=target_ip,
                    dst_mac=arp_pkt.src_mac, dst_ip=arp_pkt.src_ip))
                reply_pkt.serialize()
                self.send_packet(datapath, port, reply_pkt.data)
                self.logger.info(f"[ARP] Replied to {arp_pkt.src_ip} for {target_ip} with MAC {target_mac}")
            else:
                # Flood if we don't know and it's for the same subnet
                self._l2_flood(datapath, port, pkt.data)
                
    # --- L3 Routing Logic ---
    def _handle_l3_routing(self, datapath, in_port, pkt):
        ip_pkt = pkt.get_protocol(ipv4.ipv4)
        dst_ip = ip_pkt.dst
        src_dpid = datapath.id
        
        # 1. Find destination MAC address
        dst_mac = self.arp_table.get(dst_ip)
        if not dst_mac:
            self.logger.info(f"[ROUTING] No ARP for {dst_ip}. Buffering packet.")
            self.pending_arp_packets.setdefault(dst_ip, []).append(pkt)
            # Send ARP request from the router interface of that subnet
            dst_subnet = self.get_subnet_name(dst_ip)
            if dst_subnet:
                router_ip = self.subnets[dst_subnet]['router']
                arp_req = packet.Packet()
                arp_req.add_protocol(ethernet.ethernet(
                    dst='ff:ff:ff:ff:ff:ff', src=self.router_mac, ethertype=ether_types.ETH_TYPE_ARP))
                arp_req.add_protocol(arp.arp(
                    opcode=arp.ARP_REQUEST, src_mac=self.router_mac, src_ip=router_ip,
                    dst_mac='00:00:00:00:00:00', dst_ip=dst_ip))
                arp_req.serialize()
                self._l2_flood(datapath, in_port, arp_req.data)
            return
            
        # 2. Find destination location
        dst_location = self.get_host_location(dst_mac)
        if not dst_location:
            self.logger.warning(f"[ROUTING] Cannot locate host {dst_ip} ({dst_mac}). Flooding.")
            self._l2_flood(datapath, in_port, pkt.data)
            return
        dst_dpid, dst_port = dst_location

        # 3. Find path from source switch to destination switch
        try:
            paths = list(nx.all_shortest_paths(self.net, src_dpid, dst_dpid))
        except (nx.NetworkXNoPath, nx.NodeNotFound):
            self.logger.error(f"[ROUTING] No path from {src_dpid} to {dst_dpid}.")
            return
        path = random.choice(paths)
        self.logger.info(f"[ROUTING] Selected path {src_dpid} -> {dst_dpid}: {path}")

        # 4. Install flows along the path and send packet
        # Install L3 flow on the first switch (ingress routing)
        next_hop_dpid = path[path.index(src_dpid) + 1]
        out_port = self.net.edges[src_dpid, next_hop_dpid]['port']
        parser = datapath.ofproto_parser
        actions = [
            parser.OFPActionSetField(eth_src=self.router_mac),
            parser.OFPActionSetField(eth_dst=dst_mac),
            parser.OFPActionOutput(out_port)
        ]
        match = parser.OFPMatch(in_port=in_port, eth_type=ether_types.ETH_TYPE_IP, ipv4_dst=dst_ip)
        self.add_flow(datapath, 10, match, actions) # High priority for L3 rules
        
        # Send the buffered packet with modified headers
        self.send_packet(datapath, out_port, pkt.data) # This is not quite right, actions aren't applied to send_packet's data

        # Let's use PacketOut with actions instead
        ofproto = datapath.ofproto
        out = parser.OFPPacketOut(datapath=datapath, buffer_id=ofproto.OFP_NO_BUFFER,
                                  in_port=in_port, actions=actions, data=pkt.data)
        datapath.send_msg(out)

        # Install L2 flows on intermediate switches
        for i in range(1, len(path) - 1):
            hop_dpid = path[i]
            hop_datapath = self.switches.get(hop_dpid)
            if not hop_datapath: continue
            
            in_port = self.net.edges[hop_dpid, path[i-1]]['port']
            out_port = self.net.edges[hop_dpid, path[i+1]]['port']
            
            match = parser.OFPMatch(in_port=in_port, eth_dst=dst_mac)
            actions = [parser.OFPActionOutput(out_port)]
            self.add_flow(hop_datapath, 1, match, actions) 