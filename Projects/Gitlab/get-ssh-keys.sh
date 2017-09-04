#!/bin/bash

# Get a double-quoted, comma-separated list of our SSH keys in DigitalOcean
curl -sS \
    -H "Authorization: Bearer ${DO_PAT}" \
    https://api.digitalocean.com/v2/account/keys | \
jq '.ssh_keys[].id' | \
sed 's/^\|$/"/g' | \
paste -sd,