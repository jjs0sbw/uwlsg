#!/usr/bin/python3
import json
import os
import sys
import urllib.request

def get_digitalocean_api_key():
    return os.environ["DIGITALOCEAN_TOKEN"]

def get_all_droplets():
    req = urllib.request.Request("https://api.digitalocean.com/v2/droplets?per_page=100")
    req.add_header("Authorization", 'Bearer %s' % get_digitalocean_api_key())
    req.add_header("Accept", "application/json")
    resp = urllib.request.urlopen(req)
    content = resp.read()

    return json.loads(content.decode('utf8'))["droplets"]

def add_host_to_group(host, group, group_hash):
    if group in group_hash:
        group_hash[group]["hosts"].append(host)
    else:
        group_hash[group] = {"hosts": [host]}

def get_ipv4_address(droplet, addr_type):
    for interface in droplet["networks"]["v4"]:
        if interface["type"] == addr_type:
            return interface["ip_address"]

def get_all_groups(droplets):
    groups = { "_meta": { "hostvars": {} } }

    for droplet in droplets:
        if len(droplet["tags"]) > 0:
            for tag in droplet["tags"]:
                add_host_to_group(droplet["name"], tag, groups)
            add_host_to_group(droplet["name"], "all", groups)
            add_host_to_group(droplet["name"], "digitalocean", groups)
            add_host_to_group(droplet["name"], droplet["region"]["slug"], groups)

            groups["_meta"]["hostvars"][droplet["name"]] = {
                "ansible_host": get_ipv4_address(droplet, "public"),
                "ansible_python_intepreter": "/usr/bin/python3"
            }

    return groups

def usage():
    print("Usage: --list")
    exit(1)

if __name__ == "__main__":
    if len(sys.argv) == 1:
        usage()
    elif len(sys.argv) == 2 and sys.argv[1] == "--list":
        droplets = get_all_droplets()
        groups = get_all_groups(droplets)
        print(groups)
        #print(json.dumps(groups))
    else:
        usage()
