#!/bin/bash

gpg --import /tmp/hashicorp.asc
curl -Os https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS
curl -Os https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig
curl -Os https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
gpg --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS
sha256sum --check --ignore-missing consul_${CONSUL_VERSION}_SHA256SUMS
unzip -qq consul_${CONSUL_VERSION}_linux_amd64.zip -d /usr/bin
mkdir -p /etc/consul
consul version
