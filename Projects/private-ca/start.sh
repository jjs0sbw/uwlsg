#!/bin/bash

set -e

cd terraform
terraform apply
cd ..
ansible-playbook playbook.yml
