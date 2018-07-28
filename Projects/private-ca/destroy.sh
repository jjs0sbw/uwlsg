#!/bin/bash

set -e

cd terraform
terraform destroy -auto-approve \
    -var "username=$(whoami)" \
    -var "hostname=$(hostname)"
