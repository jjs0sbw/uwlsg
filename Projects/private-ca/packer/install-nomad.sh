#!/bin/bash

curl -Os https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_SHA256SUMS
curl -Os https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_SHA256SUMS.sig
curl -Os https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
gpg --verify nomad_${NOMAD_VERSION}_SHA256SUMS.sig nomad_${NOMAD_VERSION}_SHA256SUMS
sha256sum --check --ignore-missing nomad_${NOMAD_VERSION}_SHA256SUMS
unzip -qq nomad_${NOMAD_VERSION}_linux_amd64.zip -d /usr/bin
mkdir -p /etc/nomad
nomad version
