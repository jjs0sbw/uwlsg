control 'nomad-5' do
    impact 0.8
    title 'Ensure Nomad cluster has at least one client node.'
    desc 'Ensure Nomad cluster has at least one client node.'

    describe bash('nomad node status | grep ready | wc -l') do
        its('stdout.strip') { should cmp >= 1 }
        its('exit_status') { should eq 0 }
    end
end
