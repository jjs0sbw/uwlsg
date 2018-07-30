control 'docker-1' do
    impact 0.8
    title 'Ensure Docker is running correctly'
    desc 'Ensures the Docker daemon is running.'

    describe systemd_service('docker') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end
end
