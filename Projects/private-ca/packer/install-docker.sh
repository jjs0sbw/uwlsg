#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic edge\"
apt update -yq
apt install -y docker-ce
apt upgrade -yq
