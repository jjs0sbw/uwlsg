#!/bin/bash

# This is a helper script used to determine if an
# initialized Vault is sealed or not. We employ 
# this script to make Ansible tasks more
# idempotent. We would like to be able to
# increase our node count and run all of the tasks
# in the original provisioning playbook but avoid
# trying to reinitialize the Vault, unseal already
# operational Vault instances, or recreate any
# policies and roles that already exist.


IS_SEALED=`vault status | grep Sealed | awk '{print $2}'`

if [ $IS_SEALED == "true"  ]
then
    exit 0
else
    exit 1
fi
