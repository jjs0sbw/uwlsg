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

resource "digitalocean_domain" "compute_fqns" {
  count      = "${var.counts["compute"]}"
  name       = "${element(digitalocean_droplet.compute.*.name, count.index)}.${var.domain}"
  ip_address = "${element(digitalocean_droplet.compute.*.ipv4_address, count.index)}"
}
