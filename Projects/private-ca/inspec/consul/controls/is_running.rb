control 'consul-1' do
    impact 0.8
    title 'Ensure Consul is running correctly'
    desc 'Ensures the Consul service is running.'

    describe systemd_service('consul') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end

    describe bash('consul members | grep server | grep alive | wc -l') do
        title 'A different title'
        its('stdout') { should be >= 3 }
        its('exit_status') { should eq 0 }
      end

    describe port(8300) do
        it { should be_listening }
    end

    describe port(8301) do
        it { should be_listening }
    end

    describe port(8302) do
        it { should be_listening }
    end

    describe port(8500) do
        it { should be_listening }
    end

    describe port(8600) do
        it { should be_listening }
    end
end
