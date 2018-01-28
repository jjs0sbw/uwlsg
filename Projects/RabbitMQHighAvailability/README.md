# RabbitMQ High Availability Cluster with Consul

## Hosts file

We assume that you have control of at least six servers. I ran with Ubuntu 17.10 x64 images on DigitalOcean. The consul VMs must be tagged "consul", and the rabbitmq VMs should be tagged as "rabbitmq" (but are not required to be).

```
[consul]
consul[1:3].uwsg.tech ansible_python_interpreter=/usr/bin/python3

[rabbitmq]
rabbitmq[1:3].uwsg.tech ansible_python_interpreter=/usr/bin/python3

```

## Ansible Vault file
You need to have a file called ```vault-password.txt``` in the ```RabbitMQHighAvailability``` directory.

## Required secrets

There are secrets in the following files:

```
roles/consul-base/vars/main.yml
roles/rabbitmq/vars/main.yml
```

These provide the following secrets:
```
---
# roles/consul-base/vars/main.yml
digitalocean_api_key: xxx # An API personal access token with read/write permissions.
consul_encryption_key: xxx # A gossip encryption shared key created by the `consul keygen` command
```

```
---
# roles/rabbitmq/vars/main.yml
rabbitmq_admin_password: xxx # Password for the admin user of the management interface on port 15672.
```

## Commands to run

You should be able to provision all of these VMs using two commands:

```
./run-playbook consul.yml
./run-playbook rabbitmq.yml
```
