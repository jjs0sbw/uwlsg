#!/usr/bin/bash

find *.yml -exec kubectl apply -f {} \;
