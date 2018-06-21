provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "ca" {
  count              = 1
  image              = "ubuntu-18-04-x64"
  size               = "s-1vcpu-1gb"
  region             = "sfo1"
  name               = "ca"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["ca"]
}

resource "digitalocean_droplet" "control" {
  count              = "${var.counts["control"]}"
  image              = "ubuntu-18-04-x64"
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "control${count.index + 1}"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["hashicorp", "control"]
}

resource "digitalocean_droplet" "compute" {
  count              = "${var.counts["compute"]}"
  image              = "ubuntu-18-04-x64"
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "compute${count.index + 1}"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["hashicorp", "compute"]
}

resource "digitalocean_droplet" "loadbalancer" {
  image              = "ubuntu-18-04-x64"
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "loadbalancer-sfo1"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["loadbalancer"]
}

resource "digitalocean_domain" "ca_fqdn" {
  name       = "ca.${var.domain}"
  ip_address = "${digitalocean_droplet.ca.ipv4_address}"
}

resource "digitalocean_domain" "control_fqns" {
  count      = "${var.counts["control"]}"
  name       = "${element(digitalocean_droplet.control.*.name, count.index)}.${var.domain}"
  ip_address = "${element(digitalocean_droplet.control.*.ipv4_address, count.index)}"
}

resource "digitalocean_domain" "compute_fqns" {
  count      = "${var.counts["compute"]}"
  name       = "${element(digitalocean_droplet.compute.*.name, count.index)}.${var.domain}"
  ip_address = "${element(digitalocean_droplet.compute.*.ipv4_address, count.index)}"
}

resource "digitalocean_domain" "loadbalancer_fqdn" {
  name       = "loadbalancer.${var.domain}"
  ip_address = "${digitalocean_droplet.loadbalancer.ipv4_address}"
}
