resource "digitalocean_droplet" "control" {
  count              = "${var.counts["control"]}"
  image              = 36674475
  size               = "${var.control_size}"
  region             = "sfo1"
  name               = "control${count.index + 1}"
  ssh_keys           = ["${digitalocean_ssh_key.ssh.id}"]
  private_networking = true
  tags               = ["hashicorp", "control"]
}

resource "digitalocean_record" "control_fqdns" {
  count  = "${var.counts["control"]}"
  domain = "${var.domain}"
  type   = "A"
  ttl    = 60
  name   = "${element(digitalocean_droplet.control.*.name, count.index)}"
  value  = "${element(digitalocean_droplet.control.*.ipv4_address, count.index)}"
}
