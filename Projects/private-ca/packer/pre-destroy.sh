#!/bin/bash

NODE_NAME=${1}
REGION=${2}

DATACENTER="digitalocean-"${REGION}

echo "Cleanly draining node before destruction..."

# Check if Nomad is running. If not, safe to destroy
systemctl status docker > /dev/null 2>&1
NOMAD_STATUS=`echo $?`

netstat -tulpn | grep :4646 > /dev/null 2>&1
HTTP_PORT_LISTENING=`echo $?`

if [ $NOMAD_STATUS -ne 0 ]; then
    echo "Nomad agent was not running, allowing destruction to proceed..."
    exit 0
elif [ $HTTP_PORT_LISTENING -ne 0 ]; then
    echo "Nomad agent running but HTTP API port was not listening, allowing destruction to proceed..."
    exit 0
fi

echo "Nomad agent is running..."

NODE_ID=`nomad node status --json | jq '.[] | select(.Datacenter == "'$DATACENTER'" and .Status == "ready" and .Name == "'$NODE_NAME'").ID'`
NODE_ID=${NODE_ID:1:-1}

nomad node eligibility -disable $NODE_ID
nomad node drain -enable -deadline 10m $NODE_ID
