#!/usr/bin/env /usr/bin/python
"""Runs scripts to create infrastructure and provision it."""

from jinja2 import Environment, FileSystemLoader

# pylint: disable=C0103

env = Environment(loader=FileSystemLoader("./templates"))
infrastructure = env.get_template('cluster.tf.j2')
inventory = env.get_template('hosts.j2')

domain = "uwsg.tech"
subdomain = "k8s-"
servers = 4
size = "4gb"
sshkeys = [7172020, 7172181]
clustermembers = [subdomain+str(n) for n in range(1, servers + 1)]

with open("hosts", "w") as f:
    f.write(inventory.render(domain=domain, servers=servers))
    f.write("\n")

with open("infrastructure/cluster.tf", "w") as f:
    f.write(infrastructure.render(clustermembers=clustermembers, sshkeys=sshkeys, size=size))
    f.write("\n")
