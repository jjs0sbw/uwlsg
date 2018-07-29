control 'consul-3' do
    impact 0.8
    title 'Ensure Consul is running correctly'
    desc 'Ensures the Consul service is running.'

    describe file('/etc/consul/config.json') do
        its('content') { should match(%r{"verify_incoming": true}) }
        its('content') { should match(%r{"verify_outgoing": true}) }
        its('content') { should match(%r{"http": 0}) }
        its('content') { should match(%r{"encrypt_verify_outgoing": true}) }
        its('content') { should match(%r{"encrypt_verify_incoming": true}) }
    end
end

