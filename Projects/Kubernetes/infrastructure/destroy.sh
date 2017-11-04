#!/bin/bash

python render-cluster-configuration.py > cluster.tf

terraform destroy -var "do_token=${DO_PAT}"
