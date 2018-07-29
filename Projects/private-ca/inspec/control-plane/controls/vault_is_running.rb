control 'vault-1' do
    impact 0.8
    title 'Ensure Vault is running correctly'
    desc 'Ensures the Vault service is running.'

    describe systemd_service('vault') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end

    describe bash('vault status | grep Sealed | awk \'{print $2}\'') do
        its('stdout.strip') { should cmp 'false' }
        its('stderr') { should eq '' }
        its('exit_status') { should eq 0 }
    end

    describe port(8200) do
        it { should be_listening }
    end
end
