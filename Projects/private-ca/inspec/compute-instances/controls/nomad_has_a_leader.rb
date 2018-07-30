control 'nomad-3' do
    impact 0.8
    title 'Ensure Nomad client agents know their servers.'
    desc 'Ensure Nomad client agents know their servers.'

    describe bash('nomad agent-info | grep known_servers | awk \'{print $3}\' | tr \',\' \' \' | wc -w') do
        its('stdout.strip') { should cmp >= 3 }
        its('exit_status') { should eq 0 }
    end
end
