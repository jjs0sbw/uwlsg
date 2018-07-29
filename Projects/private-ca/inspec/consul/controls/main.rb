control 'consul' do
    impact 0.8
    title 'Ensure Consul is running correctly'

    desc '
        This test assures that the user "Bob" has a user installed on the system, along with a
        specified password.
         '

    describe systemd_service('consul') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end

    describe iptables(table: 'filter', chain: 'INPUT') do
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8300 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Consul server RPC" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8301 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Consul Serf LAN" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8302 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Consul Serf WAN" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8500 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Consul HTTP" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8600 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Consul DNS" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p udp -m udp --dport 8301 -m comment --comment "Allow Consul Serf LAN" -j ACCEPT') }
        it { should have_rule('-A INPUT -p udp -m udp --dport 8302 -m comment --comment "Allow Consul Serf WAN" -j ACCEPT') }
        it { should have_rule('-A INPUT -p udp -m udp --dport 8600 -m comment --comment "Allow Consul DNS" -j ACCEPT') }
    end
end
