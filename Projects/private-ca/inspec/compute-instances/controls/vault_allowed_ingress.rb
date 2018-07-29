control 'vault-3' do
    impact 0.8
    title 'Ensure Vault allows incoming connections'
    desc 'Checks that Vault allows ingress on required ports.'

    describe iptables(table: 'filter', chain: 'INPUT') do
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8125 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Vault telemetry" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8200 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Vault HTTP" -m conntrack --ctstate NEW -j ACCEPT') }
        it { should have_rule('-A INPUT -p tcp -m tcp --dport 8201 --tcp-flags FIN,SYN,RST,ACK SYN -m comment --comment "Allow Vault Discovery" -m conntrack --ctstate NEW -j ACCEPT') }
    end
end
