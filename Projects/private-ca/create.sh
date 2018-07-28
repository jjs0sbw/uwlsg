#!/bin/bash

set -e

cd terraform
terraform init
terraform apply -auto-approve \
    -var "username=$(whoami)" \
    -var "hostname=$(hostname)"
cd ..
ansible-playbook -i digitalocean.py playbook.yml
