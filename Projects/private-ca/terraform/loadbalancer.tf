resource "digitalocean_droplet" "loadbalancer" {
  image              = 36919902
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "loadbalancer"
  ssh_keys           = ["${digitalocean_ssh_key.ssh.id}"]
  private_networking = true
  tags               = ["loadbalancer"]
}

resource "digitalocean_record" "loadbalancer_fqdn" {
  domain = "${var.domain}"
  type   = "A"
  ttl    = 60
  name   = "${digitalocean_droplet.loadbalancer.name}"
  value  = "${digitalocean_droplet.loadbalancer.ipv4_address}"
}
