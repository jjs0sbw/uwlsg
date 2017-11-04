#!/bin/bash

python render-cluster-configuration.py > cluster.tf

terraform plan -var "do_token=${DO_PAT}"
