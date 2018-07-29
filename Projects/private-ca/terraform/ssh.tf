resource "digitalocean_ssh_key" "ssh" {
  name       = "${var.username}@${var.hostname}"
  public_key = "${file("~/.ssh/id_ed25519.pub")}"
}
