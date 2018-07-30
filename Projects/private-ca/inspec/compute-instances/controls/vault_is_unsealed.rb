control 'vault-2' do
    impact 0.8
    title 'Ensure Vault is unsealed and healthy'
    desc 'Ensures the Vault unsealed and healthy.'

    describe bash('vault status | grep Sealed | awk \'{print $2}\'') do
        its('stdout.strip') { should cmp 'false' }
        its('stderr') { should eq '' }
        its('exit_status') { should eq 0 }
    end
end
