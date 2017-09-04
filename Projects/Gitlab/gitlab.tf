resource "digitalocean_droplet" "gitlab" {
    image = "gitlab-16-04"
    name = "gitlab"
    region = "sfo1"
    size = "4gb"
    private_networking = true
    ssh_keys = [ "7172020", "7172181" ]
}

resource "digitalocean_domain" "uwsg" {
  name       = "${var.domain}"
  ip_address = "${digitalocean_droplet.gitlab.ipv4_address}"
}
