resource "digitalocean_droplet" "loadbalancer" {
  image              = "ubuntu-18-04-x64"
  size               = "s-2vcpu-2gb"
  region             = "sfo1"
  name               = "loadbalancer"
  ssh_keys           = [7172020, 7172181]
  private_networking = true
  tags               = ["loadbalancer"]
}

resource "digitalocean_domain" "loadbalancer_fqdn" {
  name       = "loadbalancer.${var.domain}"
  ip_address = "${digitalocean_droplet.loadbalancer.ipv4_address}"
}
