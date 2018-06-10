#!/bin/bash

set -e

cd terraform
terraform init
terraform apply
cd ..
ansible-playbook -i digitalocean.py playbook.yml
