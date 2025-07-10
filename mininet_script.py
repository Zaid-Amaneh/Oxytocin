from mininet.topo import Topo
from mininet.net import Mininet
from mininet.node import Node, OVSSwitch
from mininet.log import setLogLevel, info
from mininet.cli import CLI

class LinuxRouter(Node):
    "A Node with IP forwarding enabled."

    def config(self, **params):
        super(LinuxRouter, self).config(**params)
        # Enable forwarding on the router
        self.cmd('sysctl net.ipv4.ip_forward=1')

    def terminate(self):
        self.cmd('sysctl net.ipv4.ip_forward=0')
        super(LinuxRouter, self).terminate()

class MyTopo(Topo):
    def build(self):
        # Create routers
        r1 = self.addNode('r1', cls=LinuxRouter)
        r4 = self.addNode('r4', cls=LinuxRouter)

        # Create layer 2 OVS switches
        s2 = self.addSwitch('s2', cls=OVSSwitch)
        s3 = self.addSwitch('s3', cls=OVSSwitch)
        s5 = self.addSwitch('s5', cls=OVSSwitch)
        s6 = self.addSwitch('s6', cls=OVSSwitch)
        s7 = self.addSwitch('s7', cls=OVSSwitch)

        # Connect switches to routers
        # r1 connects to s2 and s3
        self.addLink(s2, r1, params1={'ip': '10.0.2.254/24'}, params2={'ip': '10.0.2.1/24'})
        self.addLink(s3, r1, params1={'ip': '10.0.3.254/24'}, params2={'ip': '10.0.3.1/24'})
        
        # r4 connects to s5, s6, s7
        self.addLink(s5, r4, params1={'ip': '10.0.5.254/24'}, params2={'ip': '10.0.5.1/24'})
        self.addLink(s6, r4, params1={'ip': '10.0.6.254/24'}, params2={'ip': '10.0.6.1/24'})
        self.addLink(s7, r4, params1={'ip': '10.0.7.254/24'}, params2={'ip': '10.0.7.1/24'})

        # Connect routers to each other, forming a backbone
        self.addLink(r1, r4, params1={'ip': '10.100.0.1/24'}, params2={'ip': '10.100.0.2/24'})
        
        # Connect other switches as per original topology
        self.addLink(s2, s3)
        self.addLink(s5, s6)
        self.addLink(s6, s7)

        # Create hosts with IP addresses and default routes
        h1 = self.addHost('h1', ip='10.0.2.10/24', defaultRoute='via 10.0.2.1')
        h2 = self.addHost('h2', ip='10.0.2.11/24', defaultRoute='via 10.0.2.1')
        
        h3 = self.addHost('h3', ip='10.0.3.10/24', defaultRoute='via 10.0.3.1')
        h4 = self.addHost('h4', ip='10.0.3.11/24', defaultRoute='via 10.0.3.1')

        h5 = self.addHost('h5', ip='10.0.5.10/24', defaultRoute='via 10.0.5.1')
        h6 = self.addHost('h6', ip='10.0.5.11/24', defaultRoute='via 10.0.5.1')

        h7 = self.addHost('h7', ip='10.0.6.10/24', defaultRoute='via 10.0.6.1')
        h8 = self.addHost('h8', ip='10.0.6.11/24', defaultRoute='via 10.0.6.1')

        h9 = self.addHost('h9', ip='10.0.7.10/24', defaultRoute='via 10.0.7.1')
        h10 = self.addHost('h10', ip='10.0.7.11/24', defaultRoute='via 10.0.7.1')

        # Connect hosts to switches
        self.addLink(s2, h1)
        self.addLink(s2, h2)
        self.addLink(s3, h3)
        self.addLink(s3, h4)
        self.addLink(s5, h5)
        self.addLink(s5, h6)
        self.addLink(s6, h7)
        self.addLink(s6, h8)
        self.addLink(s7, h9)
        self.addLink(s7, h10)

def run():
    "Test linux router"
    topo = MyTopo()
    net = Mininet(topo=topo, waitConnected=True)
    
    # Add static routes to routers
    r1 = net.get('r1')
    r4 = net.get('r4')

    info(r1.cmd('ip route add 10.0.5.0/24 via 10.100.0.2'))
    info(r1.cmd('ip route add 10.0.6.0/24 via 10.100.0.2'))
    info(r1.cmd('ip route add 10.0.7.0/24 via 10.100.0.2'))
    
    info(r4.cmd('ip route add 10.0.2.0/24 via 10.100.0.1'))
    info(r4.cmd('ip route add 10.0.3.0/24 via 10.100.0.1'))

    net.start()
    info('*** Routing Table on Router r1:\n')
    info(net['r1'].cmd('route'))
    info('*** Routing Table on Router r4:\n')
    info(net['r4'].cmd('route'))
    
    info('*** Pinging all hosts...\n')
    net.pingAll()
    
    info('*** ARP table on r1:\n')
    info(net['r1'].cmd('arp -n'))

    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
    run()

topos = {'mytopo': (lambda: MyTopo())} 