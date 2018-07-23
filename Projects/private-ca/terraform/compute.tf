resource "digitalocean_droplet" "compute" {
  count              = "${var.counts["compute"]}"
  image              = "ubuntu-18-04-x64"
  size               = "${var.compute_size}"
  region             = "sfo1"
  name               = "compute${count.index + 1}"
  ssh_keys           = ["${digitalocean_ssh_key.ssh.id}"]
  private_networking = true
  tags               = ["hashicorp", "compute"]

  provisioner "remote-exec" {
    when    = "destroy"
    inline  = [
      "/usr/bin/pre-destroy.sh ${self.name} ${self.region}"
    ]
  }
}

resource "digitalocean_record" "compute_fqdns" {
  count  = "${var.counts["compute"]}"
  domain = "${var.domain}"
  type   = "A"
  ttl    = 60
  name   = "${element(digitalocean_droplet.compute.*.name, count.index)}"
  value  = "${element(digitalocean_droplet.compute.*.ipv4_address, count.index)}"
}
