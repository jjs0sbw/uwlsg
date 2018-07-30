control 'cfssl-1' do
    impact 0.8
    title 'Ensure Cloudflare SSL is running correctly'
    desc 'Ensures that Cloudflare SSL is running.'

    describe systemd_service('cfssl') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end

    describe port(443) do
        it { should be_listening }
    end

    describe port(80) do
        it { should_not be_listening }
    end
end
