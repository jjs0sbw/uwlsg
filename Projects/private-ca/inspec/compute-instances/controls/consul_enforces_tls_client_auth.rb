control 'consul-server-1' do
    impact 0.8
    title 'Ensure Consul requires TLS mutual authentication'
    desc 'Ensures Consul servers are configured to require client TLS certificates and that HTTP is disabled.'

    describe json('/etc/consul/config.json') do
        its('verify_incoming') { should eq true }
        its('encrypt_verify_incoming') { should eq true }
        its('verify_outgoing') { should eq true }
        its('encrypt_verify_outgoing') { should eq true }
        its(['ports', 'http']) { should eq 0 }
        its(['ports', 'https']) { should eq 8500 }
    end
end
