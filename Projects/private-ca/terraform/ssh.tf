resource "digitalocean_ssh_key" "ssh" {
  name       = "jump@root"
  public_key = "${file("~/.ssh/id_ed25519.pub")}"
}
