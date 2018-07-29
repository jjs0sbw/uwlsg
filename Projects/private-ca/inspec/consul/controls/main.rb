control 'consul' do
    impact 0.8
    desc '
        This test assures that the user "Bob" has a user installed on the system, along with a
        specified password.
         '

    describe systemd_service('consul') do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
    end
end
