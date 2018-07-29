control 'nomad-2' do
    impact 0.8
    title 'Ensure Nomad allows incoming connections'
    desc 'Checks that Nomad allows ingress on required ports.'

    describe iptables(table: 'filter', chain: 'INPUT') do
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 4646 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Nomad HTTP" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 4647 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Nomad RPC" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 4648 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Nomad Serf WAN" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p udp -m udp --dport 4648 -m comment --comment "Allow Nomad Serf WAN" -j ACCEPT') }
    end
end
