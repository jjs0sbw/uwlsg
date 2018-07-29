control 'consul-3' do
    impact 0.8
    title 'Ensure Consul is running correctly'
    desc 'Ensures the Consul service is running.'

    describe file('/etc/consul/config.json') do
        its('content') { should match(%r{"verify_incoming": true}) }
        its('content') { should match(%r{host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5}) }
        its('content') { should match(%r{host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5}) }
    end
end

