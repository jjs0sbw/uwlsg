provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-14-04-x64"
  name   = "web-1"
  region = "nyc2"
  size   = "s-2vcpu-2gb"
}
