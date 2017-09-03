

resource "digitalocean_droplet" "gitlab" {
    image = "ubuntu-14-04-x64"
    name = "gitlab"
    region = "sfo1"
    size = "512mb"
    private_networking = true
    ssh_keys = "${var.ssh_keys}"
}