control 'nomad-3' do
    impact 0.8
    title 'Ensure Nomad has elected a leader.'
    desc 'Ensures that the Consul cluster has a leader.'

    describe bash('nomad agent-info | grep leader_addr | awk \'{print $3}\'') do
        its('stdout.strip') { should_not cmp '' }
        its('exit_status') { should eq 0 }
    end
end
