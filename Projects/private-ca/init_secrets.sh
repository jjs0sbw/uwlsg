#!/bin/bash

# Cleanup any existing secret files for Ansible and regenerate them
echo "[+] Creating Ansible password file"
rm -f pwd.txt
echo $(openssl rand -base64 32) >> pwd.txt

echo "[+] Regenerating group_vars/all/secrets.yml"
rm -f group_vars/all/secrets.yml
echo "consul_gossip_key: "$(openssl rand -base64 16) >> group_vars/all/secrets.yml
echo "nomad_gossip_key: "$(openssl rand -base64 16) >> group_vars/all/secrets.yml
echo "ca_shared_key: "$(openssl rand -hex 16) >> group_vars/all/secrets.yml
ansible-vault encrypt group_vars/all/secrets.yml

echo "[+] Recreating certificate authority root key material."

mkdir -p roles/trust-ca-root/files
cd roles/ca/files

cfssl gencert -initca csr.json | cfssljson -bare ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem ca-server-csr.json | cfssljson -bare ca-server
cp ca.pem ../../trust-ca-root/files/ca.pem
