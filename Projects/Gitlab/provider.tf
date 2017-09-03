variable "do_token" {}
variable 

provider "digitalocean" {
  token = "${var.do_token}"
}
