#!/usr/bin/bash

python templates.py
cd infrastructure
bash apply.sh
cd ..
ansible-playbook cluster.yml
