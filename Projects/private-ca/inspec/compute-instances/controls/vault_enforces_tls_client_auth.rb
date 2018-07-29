control 'vault-4' do
    impact 0.8
    title 'Ensure Vault requires TLS mutual authentication'
    desc 'Ensures Vault agents are configured to require client TLS certificates.'

    describe file('/etc/vault/config.hcl') do
        its('content') { should match(%r{tls_require_and_verify_client_cert = "true"}) }
    end
end
