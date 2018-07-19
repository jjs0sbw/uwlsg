#!/bin/bash

set -e

cd terraform
terraform init
terraform apply -auto-approve
cd ..
ansible-playbook -i digitalocean.py playbook.yml
