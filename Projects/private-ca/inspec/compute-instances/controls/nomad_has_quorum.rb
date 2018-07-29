control 'nomad-4' do
    impact 0.8
    title 'Ensure Nomad cluster has quorum.'
    desc 'Ensures Nomad cluster has quorum.'

    describe bash('nomad server members | grep alive | wc -l') do
        its('stdout.strip') { should cmp >= 3 }
        its('exit_status') { should eq 0 }
    end
end
