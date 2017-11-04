#!/bin/bash

python render-cluster-configuration.py > cluster.tf

terraform apply -var "do_token=${DO_PAT}"
