#!/bin/bash

curl -sS \
    -H "Authorization: Bearer ${DO_PAT}" \
    https://api.digitalocean.com/v2/account/keys \
| jq '.ssh_keys[].id'