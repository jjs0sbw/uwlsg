#!/bin/bash

curl -Os https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS
curl -Os https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig
curl -Os https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
gpg --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS
sha256sum --check --ignore-missing vault_${VAULT_VERSION}_SHA256SUMS
unzip -qq vault_${VAULT_VERSION}_linux_amd64.zip -d /usr/bin
mkdir -p /etc/vault
vault version
