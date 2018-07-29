control 'nomad-1' do
    impact 0.8
    title 'Ensure Nomad is running correctly'
    desc 'Ensures the Nomad service is running.'

    describe systemd_service('nomad') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end

    describe port(4646) do
        it { should be_listening }
    end

    describe port(4647) do
        it { should be_listening }
    end
end
