resource "digitalocean_droplet" "control" {
  count              = "${var.counts["control"]}"
  image              = "ubuntu-18-04-x64"
  size               = "${var.control_size}"
  region             = "sfo1"
  name               = "control${count.index + 1}"
  ssh_keys           = "${var.ssh_keys}"
  private_networking = true
  tags               = ["hashicorp", "control"]
}

resource "digitalocean_domain" "control_fqns" {
  count      = "${var.counts["control"]}"
  name       = "${element(digitalocean_droplet.control.*.name, count.index)}.${var.domain}"
  ip_address = "${element(digitalocean_droplet.control.*.ipv4_address, count.index)}"
}
