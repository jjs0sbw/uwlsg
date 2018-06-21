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

resource "digitalocean_tag" "loadbalancer_tag" {
  name = "loadbalancer"
}
