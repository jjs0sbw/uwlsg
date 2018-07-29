control 'consul' do
    impact 0.8
    title 'Ensure Consul is running correctly'
    desc 'Ensures the Consul service is running.'

    describe systemd_service('consul') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end
end
