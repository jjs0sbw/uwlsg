#!/bin/bash

mkdir -p roles/trust-ca-root/files
cd roles/ca/files

cfssl gencert -initca csr.json | cfssljson -bare ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem ca-server-csr.json | cfssljson -bare ca-server
cp ca.pem ../../trust-ca-root/files/ca.pem