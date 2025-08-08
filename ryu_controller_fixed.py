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

class CombinedApp(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    # DHCP Constants
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
        super(CombinedApp, self).__init__(*args, **kwargs)

        # --- Logging ---
        self.logger.setLevel(logging.INFO)

        # --- Topology Discovery ---
        self.net = nx.DiGraph()
        self.switches = {}  # dpid -> datapath object
        self.mac_to_port = {}  # dpid -> {mac -> port}
        self.lldp_delay = 5
        self.discovery_thread = hub.spawn(self._lldp_loop)

        # --- L3 Routing & ARP ---
        self.router_mac = 'aa:bb:cc:dd:ee:ff'
        self.arp_table = {}  # ip -> mac
        self.pending_packets = {}  # ip -> list of buffered (datapath, packet_data) tuples

        # --- DHCP Server Config ---
        self.dhcp_server_ip = '192.168.196.144'
        self.subnets = self._setup_subnets()
        self.leases = {}  # mac -> {ip, subnet_name, lease_end}

    def _setup_subnets(self):
        """Initializes subnet configurations."""
        subnets = {
            's2': {'network': '192.168.4.0/25', 'pool_range': ['192.168.4.4', '192.168.4.126'], 'router': '192.168.4.1', 'subnet_mask': '255.255.255.128'},
            's3': {'network': '192.168.0.0/26', 'pool_range': ['192.168.0.4', '192.168.0.62'], 'router': '192.168.0.1', 'subnet_mask': '255.255.255.192'},
            's4': {'network': '192.168.0.64/22', 'pool_range': ['192.168.0.70', '192.168.3.254'], 'router': '192.168.0.65', 'subnet_mask': '255.255.252.0'}
        }
        # Apply common settings and initialize IP pools
        for name, config in subnets.items():
            config['server_ip'] = self.dhcp_server_ip
            config['dns_server'] = '8.8.8.8'
            config['lease_time'] = 86400
            start_ip = ip_address(config['pool_range'][0])
            end_ip = ip_address(config['pool_range'][1])
            config['pool'] = [str(ip) for ip in range(int(start_ip), int(end_ip) + 1)]
        
        # s5, s6, s7 share the configuration of s4
        subnets['s5'] = subnets['s4']
        subnets['s6'] = subnets['s4']
        subnets['s7'] = subnets['s4']
        return subnets

    # --- Generic Helper Methods ---
    def get_subnet_name_by_ip(self, ip_str):
        ip = ip_address(ip_str)
        for name, subnet in self.subnets.items():
            if ip in ip_network(subnet['network'], strict=False):
                return name
        return None

    def get_host_location(self, mac):
        """Find the switch dpid and port where a host is connected."""
        for dpid, mac_table in self.mac_to_port.items():
            if mac in mac_table:
                return (dpid, mac_table[mac])
        return (None, None)

    def add_flow(self, datapath, priority, match, actions):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        inst = [parser.OFPInstructionActions(ofproto.OFPIT_APPLY_ACTIONS, actions)]
        mod = parser.OFPFlowMod(datapath=datapath, priority=priority, match=match, instructions=inst)
        datapath.send_msg(mod)

    def send_packet(self, datapath, port, data):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        actions = [parser.OFPActionOutput(port)]
        out = parser.OFPPacketOut(datapath=datapath, buffer_id=ofproto.OFP_NO_BUFFER,
                                  in_port=ofproto.OFPP_CONTROLLER, actions=actions, data=data)
        datapath.send_msg(out)

    # --- Topology Discovery (LLDP) ---
    def _lldp_loop(self):
        """Periodically send LLDP packets out of all active switch ports."""
        while True:
            for datapath in list(self.switches.values()):
                self._send_lldp_packet(datapath)
            hub.sleep(self.lldp_delay)

    def _send_lldp_packet(self, datapath):
        ofproto = datapath.ofproto
        for port_no, port in datapath.ports.items():
            if port.port_no != ofproto_v1_3.OFPP_LOCAL:
                pkt = packet.Packet()
                pkt.add_protocol(ethernet.ethernet(ethertype=ether_types.ETH_TYPE_LLDP,
                                                   src=port.hw_addr,
                                                   dst=lldp.LLDP_MAC_NEAREST_BRIDGE))
                tlv_chassis_id = lldp.ChassisID(chassis_id=str(datapath.id).encode('utf-8'))
                tlv_port_id = lldp.PortID(port_id=str(port_no).encode('utf-8'))
                tlv_ttl = lldp.TTL(ttl=120)
                tlv_end = lldp.End()
                pkt.add_protocol(lldp.lldp(tlvs=[tlv_chassis_id, tlv_port_id, tlv_ttl, tlv_end]))
                pkt.serialize()
                self.send_packet(datapath, port_no, pkt.data)

    def _handle_lldp(self, datapath, port, pkt_lldp):
        """Handles a received LLDP packet to discover links."""
        try:
            src_dpid = int(pkt_lldp.tlvs[0].chassis_id)
            src_port_no = int(pkt_lldp.tlvs[1].port_id)
            dst_dpid = datapath.id

            if src_dpid not in self.switches:
                return # Ignore LLDP from unknown switches

            # Add edge to network graph
            if not self.net.has_edge(src_dpid, dst_dpid):
                self.net.add_edge(src_dpid, dst_dpid, port=src_port_no)
                self.net.add_edge(dst_dpid, src_dpid, port=port)
                self.logger.info(f"[TOPOLOGY] Discovered link: s{src_dpid}(p{src_port_no}) <-> s{dst_dpid}(p{port})")
        except (ValueError, IndexError):
            # Ignore malformed LLDP packets
            return

    # --- Switch Connection Handlers ---
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        # Install table-miss flow to send all non-matching packets to controller
        match = parser.OFPMatch()
        actions = [parser.OFPActionOutput(ofproto.OFPP_CONTROLLER, ofproto.OFPCML_NO_BUFFER)]
        self.add_flow(datapath, 0, match, actions)

        # Register the switch
        self.logger.info(f"[SWITCH] Switch connected: DPID={datapath.id}")
        self.switches[datapath.id] = datapath
        self.mac_to_port.setdefault(datapath.id, {})
        if not self.net.has_node(datapath.id):
            self.net.add_node(datapath.id)


    @set_ev_cls(ofp_event.EventOFPStateChange, [MAIN_DISPATCHER, DEAD_DISPATCHER])
    def _state_change_handler(self, ev):
        datapath = ev.datapath
        if ev.state == DEAD_DISPATCHER:
            if datapath.id in self.switches:
                del self.switches[datapath.id]
            if self.net.has_node(datapath.id):
                self.net.remove_node(datapath.id)
            self.logger.warning(f"[SWITCH] Switch disconnected: DPID={datapath.id}")

    # --- Packet-In Handler and Logic ---
    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
        msg = ev.msg
        datapath = msg.datapath
        in_port = msg.match['in_port']
        pkt = packet.Packet(msg.data)
        eth_pkt = pkt.get_protocol(ethernet.ethernet)

        if not eth_pkt or eth_pkt.dst.startswith('01:00:5e'): # Ignore non-ethernet and multicast
            return

        if eth_pkt.ethertype == ether_types.ETH_TYPE_LLDP:
            self._handle_lldp(datapath, in_port, pkt.get_protocol(lldp.lldp))
            return
            
        if eth_pkt.ethertype == ether_types.ETH_TYPE_IPV6:
            return

        # Learn host MAC address and location
        self.mac_to_port[datapath.id][eth_pkt.src] = in_port

        # Dispatch to appropriate handler
        if eth_pkt.ethertype == ether_types.ETH_TYPE_ARP:
            self._handle_arp(datapath, in_port, pkt)
        elif eth_pkt.ethertype == ether_types.ETH_TYPE_IP:
            self._handle_ip(datapath, in_port, pkt)

    def _handle_arp(self, datapath, port, pkt):
        arp_pkt = pkt.get_protocol(arp.arp)
        eth_pkt = pkt.get_protocol(ethernet.ethernet)

        # Learn the IP-to-MAC mapping from the ARP source
        if arp_pkt.src_ip != '0.0.0.0':
            self.arp_table[arp_pkt.src_ip] = arp_pkt.src_mac
            # If this ARP resolves any pending packets, forward them now
            if arp_pkt.src_ip in self.pending_packets:
                self.logger.info(f"[ROUTING] Resolved ARP for {arp_pkt.src_ip}, processing {len(self.pending_packets[arp_pkt.src_ip])} pending packet(s).")
                for pending_datapath, pending_pkt_data in self.pending_packets.pop(arp_pkt.src_ip):
                    self._handle_l3_routing(pending_datapath, packet.Packet(pending_pkt_data))
                
        if arp_pkt.opcode != arp.ARP_REQUEST:
            return

        # --- Handle ARP Request ---
        target_ip = arp_pkt.dst_ip
        src_ip = arp_pkt.src_ip
        
        # Determine if we should send a reply
        reply_mac = None
        src_subnet = self.get_subnet_name_by_ip(src_ip)
        dst_subnet = self.get_subnet_name_by_ip(target_ip)

        # Case 1: ARP is for a known host in our table
        if target_ip in self.arp_table:
            reply_mac = self.arp_table[target_ip]
        # Case 2: ARP is for a router interface
        elif dst_subnet and target_ip == self.subnets[dst_subnet]['router']:
            reply_mac = self.router_mac
        # Case 3: Proxy ARP for a request to a different subnet
        elif src_subnet and dst_subnet and src_subnet != dst_subnet:
            reply_mac = self.router_mac
        
        if reply_mac:
            self.logger.info(f"[ARP] Replying to {src_ip} for {target_ip} with MAC {reply_mac}")
            reply_pkt = packet.Packet()
            reply_pkt.add_protocol(ethernet.ethernet(dst=eth_pkt.src, src=reply_mac, ethertype=ether_types.ETH_TYPE_ARP))
            reply_pkt.add_protocol(arp.arp(opcode=arp.ARP_REPLY, src_mac=reply_mac, src_ip=target_ip,
                                           dst_mac=arp_pkt.src_mac, dst_ip=src_ip))
            reply_pkt.serialize()
            self.send_packet(datapath, port, reply_pkt.data)
        else:
            # If we don't know the MAC and it's for the same subnet, flood the request
            self.logger.info(f"[ARP] Flooding request for unknown host {target_ip} in local subnet.")
            self.send_packet(datapath, datapath.ofproto.OFPP_FLOOD, pkt.data)

    def _handle_ip(self, datapath, port, pkt):
        ip_pkt = pkt.get_protocol(ipv4.ipv4)

        if pkt.get_protocol(udp.udp) and pkt.get_protocol(dhcp.dhcp):
            self._handle_dhcp(datapath, port, pkt)
            return

        # Check if packet is destined for one of our router interfaces
        if ip_pkt.proto == 1 and pkt.get_protocol(icmp.icmp): # ICMP
             dst_subnet = self.get_subnet_name_by_ip(ip_pkt.dst)
             if dst_subnet and ip_pkt.dst == self.subnets[dst_subnet]['router']:
                 self._handle_icmp_to_router(datapath, port, pkt)
                 return

        # Determine if packet needs L2 or L3 forwarding
        src_subnet = self.get_subnet_name_by_ip(ip_pkt.src)
        dst_subnet = self.get_subnet_name_by_ip(ip_pkt.dst)
        
        if src_subnet and dst_subnet and src_subnet != dst_subnet:
            self._handle_l3_routing(datapath, pkt)
        else:
            self._handle_l2_forwarding(datapath, pkt)

    def _handle_l2_forwarding(self, datapath, pkt):
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        dst_mac = eth_pkt.dst
        dpid = datapath.id

        location = self.get_host_location(dst_mac)
        if location:
            # If destination is on a known switch, find path and install flows
            dst_dpid, out_port = location
            if dpid == dst_dpid: # Destination on same switch
                self.logger.info(f"[L2] Forwarding packet for {dst_mac} on s{dpid} to port {out_port}")
                actions = [datapath.ofproto_parser.OFPActionOutput(out_port)]
                match = datapath.ofproto_parser.OFPMatch(eth_dst=dst_mac)
                self.add_flow(datapath, 1, match, actions)
                self.send_packet(datapath, out_port, pkt.data)
            else: # Destination on different switch (should be handled by L3 logic for routed traffic)
                self.logger.warning(f"[L2] L2 packet for {dst_mac} needs to cross switches. This should be L3.")
                self.send_packet(datapath, datapath.ofproto.OFPP_FLOOD, pkt.data)
        else:
            # If destination location is unknown, flood
            self.logger.info(f"[L2] Unknown destination {dst_mac}, flooding packet.")
            self.send_packet(datapath, datapath.ofproto.OFPP_FLOOD, pkt.data)

    def _handle_l3_routing(self, datapath, pkt):
        ip_pkt = pkt.get_protocol(ipv4.ipv4)
        dst_ip = ip_pkt.dst
        src_dpid = datapath.id

        # 1. Find destination MAC address via ARP table
        dst_mac = self.arp_table.get(dst_ip)
        if not dst_mac:
            self.logger.info(f"[ROUTING] No ARP entry for {dst_ip}. Buffering packet and sending ARP request.")
            # Buffer the packet
            self.pending_packets.setdefault(dst_ip, []).append((datapath, pkt.data))
            # Send ARP request from the correct router interface
            dst_subnet_name = self.get_subnet_name_by_ip(dst_ip)
            if dst_subnet_name:
                router_ip = self.subnets[dst_subnet_name]['router']
                arp_req = self._build_arp_request(router_ip, dst_ip)
                # Flood the ARP request to find the host
                for dpid in self.switches:
                    self.send_packet(self.switches[dpid], self.switches[dpid].ofproto.OFPP_FLOOD, arp_req.data)
            return

        # 2. Find destination host location (switch and port)
        dst_location = self.get_host_location(dst_mac)
        if not dst_location or not dst_location[0]:
            self.logger.warning(f"[ROUTING] Cannot locate host {dst_ip} ({dst_mac}). Flooding packet.")
            self.send_packet(datapath, datapath.ofproto.OFPP_FLOOD, pkt.data)
            return
        dst_dpid, dst_port = dst_location

        # 3. Find a path from the source switch to the destination switch
        try:
            paths = list(nx.all_shortest_paths(self.net, src_dpid, dst_dpid))
        except (nx.NetworkXNoPath, nx.NodeNotFound):
            self.logger.error(f"[ROUTING] No path found in network graph from s{src_dpid} to s{dst_dpid}.")
            return
        
        path = random.choice(paths)
        self.logger.info(f"[ROUTING] Selected path for {ip_pkt.src} -> {ip_pkt.dst}: {' -> '.join(map(str, path))}")

        # 4. Install flow rules along the path
        for i, node_dpid in enumerate(path):
            node_datapath = self.switches[node_dpid]
            parser = node_datapath.ofproto_parser
            
            if i < len(path) - 1: # Not the last switch
                next_node_dpid = path[i+1]
                out_port = self.net.edges[node_dpid, next_node_dpid]['port']
            else: # Last switch in path
                out_port = dst_port

            # On the first switch, rewrite MACs and forward
            if i == 0:
                match = parser.OFPMatch(eth_type=ether_types.ETH_TYPE_IP, ipv4_dst=dst_ip)
                actions = [parser.OFPActionSetField(eth_src=self.router_mac),
                           parser.OFPActionSetField(eth_dst=dst_mac),
                           parser.OFPActionOutput(out_port)]
                self.logger.info(f"[ROUTING] Installing L3 flow on s{node_dpid}: match_dst_ip={dst_ip} -> set_macs, output to {out_port}")
                self.add_flow(node_datapath, 10, match, actions)
            # On intermediate switches, just forward based on dst MAC
            else:
                match = parser.OFPMatch(eth_dst=dst_mac)
                actions = [parser.OFPActionOutput(out_port)]
                self.logger.info(f"[ROUTING] Installing L2-style flow on s{node_dpid}: match_dst_mac={dst_mac} -> output to {out_port}")
                self.add_flow(node_datapath, 5, match, actions)
        
        # 5. Send the original packet along the first hop with rewritten MACs
        actions = [parser.OFPActionSetField(eth_src=self.router_mac),
                   parser.OFPActionSetField(eth_dst=dst_mac),
                   parser.OFPActionOutput(self.net.edges[src_dpid, path[1]]['port'])]
        out = parser.OFPPacketOut(datapath=datapath, buffer_id=datapath.ofproto.OFP_NO_BUFFER,
                                  in_port=datapath.ofproto.OFPP_CONTROLLER, actions=actions, data=pkt.data)
        datapath.send_msg(out)

    def _build_arp_request(self, src_ip, target_ip):
        pkt = packet.Packet()
        pkt.add_protocol(ethernet.ethernet(dst='ff:ff:ff:ff:ff:ff', src=self.router_mac, ethertype=ether_types.ETH_TYPE_ARP))
        pkt.add_protocol(arp.arp(opcode=arp.ARP_REQUEST, src_mac=self.router_mac, src_ip=src_ip,
                                 dst_mac='00:00:00:00:00:00', dst_ip=target_ip))
        pkt.serialize()
        return pkt

    def _handle_icmp_to_router(self, datapath, port, pkt):
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        ip_pkt = pkt.get_protocol(ipv4.ipv4)
        icmp_pkt = pkt.get_protocol(icmp.icmp)

        if icmp_pkt.type != icmp.ICMP_ECHO_REQUEST: return

        self.logger.info(f"[ICMP] Replying to ping for router interface {ip_pkt.dst}")
        reply_pkt = packet.Packet()
        reply_pkt.add_protocol(ethernet.ethernet(dst=eth_pkt.src, src=self.router_mac, ethertype=ether_types.ETH_TYPE_IP))
        reply_pkt.add_protocol(ipv4.ipv4(dst=ip_pkt.src, src=ip_pkt.dst, proto=ip_pkt.proto))
        reply_pkt.add_protocol(icmp.icmp(type_=icmp.ICMP_ECHO_REPLY, code=icmp.ICMP_ECHO_REPLY_CODE, csum=0, data=icmp_pkt.data))
        reply_pkt.serialize()
        self.send_packet(datapath, port, reply_pkt.data)

    def _handle_dhcp(self, datapath, port, pkt):
        dhcp_pkt = pkt.get_protocol(dhcp.dhcp)
        eth_pkt = pkt.get_protocol(ethernet.ethernet)
        mac = eth_pkt.src
        switch_name = f's{datapath.id}'
        xid = dhcp_pkt.xid

        try:
            msg_type = dhcp_pkt.options.get_option(self.DHCP_MESSAGE_TYPE).value[0]
            subnet_info = self.subnets.get(switch_name)
            if not subnet_info:
                self.logger.warning(f"[DHCP] Request from unknown switch {switch_name}")
                return

            if msg_type == self.DHCP_DISCOVER:
                lease = self.leases.get(mac)
                if lease and lease['lease_end'] > time.time():
                    ip_to_offer = lease['ip']
                elif subnet_info['pool']:
                    ip_to_offer = subnet_info['pool'][0] # Offer without removing yet
                else:
                    self.logger.error(f"[DHCP] IP Pool for {switch_name} is empty!")
                    return
                
                options = self._get_dhcp_options(self.DHCP_OFFER, subnet_info)
                reply = self._build_dhcp_response(mac, ip_to_offer, xid, subnet_info, options)
                self.send_packet(datapath, port, reply.data)
                self.logger.info(f"[DHCP] Offered {ip_to_offer} to {mac} on {switch_name}")

            elif msg_type == self.DHCP_REQUEST:
                req_ip_opt = dhcp_pkt.options.get_option(self.DHCP_REQUESTED_IP)
                if not req_ip_opt: return
                requested_ip = addrconv.ipv4.bin_to_text(req_ip_opt.value)

                # Commit lease
                if requested_ip in subnet_info['pool']:
                    subnet_info['pool'].remove(requested_ip)
                self.leases[mac] = {'ip': requested_ip, 'subnet_name': switch_name, 'lease_end': time.time() + subnet_info['lease_time']}
                self.arp_table[requested_ip] = mac
                
                options = self._get_dhcp_options(self.DHCP_ACK, subnet_info)
                reply = self._build_dhcp_response(mac, requested_ip, xid, subnet_info, options)
                self.send_packet(datapath, port, reply.data)
                self.logger.info(f"[DHCP] ACK for {requested_ip} sent to {mac}. Lease committed.")
        except Exception as e:
            self.logger.error(f"[DHCP] Error handling DHCP packet: {e}")

    def _get_dhcp_options(self, msg_type, subnet_info):
        return [
            dhcp.option(tag=self.DHCP_MESSAGE_TYPE, value=bytes([msg_type])),
            dhcp.option(tag=self.DHCP_SERVER_ID, value=addrconv.ipv4.text_to_bin(subnet_info['server_ip'])),
            dhcp.option(tag=self.DHCP_LEASE_TIME, value=struct.pack('!I', subnet_info['lease_time'])),
            dhcp.option(tag=self.DHCP_SUBNET_MASK, value=addrconv.ipv4.text_to_bin(subnet_info['subnet_mask'])),
            dhcp.option(tag=self.DHCP_ROUTER, value=addrconv.ipv4.text_to_bin(subnet_info['router'])),
            dhcp.option(tag=self.DHCP_DNS_SERVER, value=addrconv.ipv4.text_to_bin(subnet_info['dns_server'])),
            dhcp.option(tag=self.DHCP_END, value=b'')
        ]

    def _build_dhcp_response(self, mac, ip, xid, subnet_info, options):
        pkt = packet.Packet()
        pkt.add_protocol(ethernet.ethernet(ethertype=ether_types.ETH_TYPE_IP, dst='ff:ff:ff:ff:ff:ff', src=self.router_mac))
        pkt.add_protocol(ipv4.ipv4(dst='255.255.255.255', src=subnet_info['server_ip'], proto=17))
        pkt.add_protocol(udp.udp(src_port=67, dst_port=68))
        pkt.add_protocol(dhcp.dhcp(op=2, chaddr=addrconv.mac.text_to_bin(mac), yiaddr=ip, 
                                   siaddr=subnet_info['server_ip'], xid=xid, options=dhcp.options(option_list=options)))
        pkt.serialize()
        return pkt 