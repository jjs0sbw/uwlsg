control 'haproxy-1' do
    impact 0.8
    title 'Ensure HAProxy is running correctly'
    desc 'Ensures the HAProxy service is running.'

    describe systemd_service('haproxy') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end

    describe port(443) do
        it { should be_listening }
    end

    describe port(80) do
        it { should be_listening }
    end
end
