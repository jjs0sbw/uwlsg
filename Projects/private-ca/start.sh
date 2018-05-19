#!/bin/bash

set -e

cd terraform
terraform init
terraform apply
cd ..
ansible-playbook playbook.yml
