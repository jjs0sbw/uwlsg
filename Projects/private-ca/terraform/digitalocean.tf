provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_tag" "control_tag" {
  name = "control"
}

resource "digitalocean_tag" "compute_tag" {
  name = "compute"
}

resource "digitalocean_droplet" "control" {
  count              = 3
  image              = "ubuntu-18-04-x64"
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "control${count.index + 1}"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["control"]
}

resource "digitalocean_droplet" "compute" {
  count              = 2
  image              = "ubuntu-18-04-x64"
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "compute${count.index + 1}"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["compute"]
}

resource "digitalocean_domain" "control_fqns" {
  count      = 3
  name       = "${element(digitalocean_droplet.control.*.name, count.index)}.adriennecohea.ninja"
  ip_address = "${element(digitalocean_droplet.control.*.ipv4_address, count.index)}"
}

resource "digitalocean_domain" "compute_fqns" {
  count      = 2
  name       = "${element(digitalocean_droplet.compute.*.name, count.index)}.adriennecohea.ninja"
  ip_address = "${element(digitalocean_droplet.compute.*.ipv4_address, count.index)}"
}
