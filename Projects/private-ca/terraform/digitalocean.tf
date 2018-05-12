provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_tag" "control_tag" {
  name = "control"
}

resource "digitalocean_tag" "compute_tag" {
  name = "compute"
}

resource "digitalocean_tag" "hashicorp_tag" {
  name = "hashicorp"
}

resource "digitalocean_tag" "ca_tag" {
  name = "ca"
}

variable "domain" {
  default = "adriennecohea.ninja"
}

variable "counts" {
  type = "map"

  default = {
    "compute" = 1
    "control" = 3
  }
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
