resource "digitalocean_droplet" "ca" {
  count              = 1
  image              = 36719599
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "ca"
  ssh_keys           = ["${digitalocean_ssh_key.ssh.id}"]
  private_networking = true
  tags               = ["ca"]
}

resource "digitalocean_record" "ca_fqdn" {
  domain = "${var.domain}"
  type   = "A"
  ttl    = 60
  name   = "ca"
  value  = "${digitalocean_droplet.ca.ipv4_address}"
}
