#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sleep 30
apt update -yq
apt install -y golang-cfssl unzip apt-transport-https ca-certificates curl software-properties-common build-essential ruby ruby-dev python3-pip jq dnsmasq
gem install --no-rdoc --no-ri inspec
inspec version
mkdir -p /etc/inspec
pip3 install pexpect
sync
