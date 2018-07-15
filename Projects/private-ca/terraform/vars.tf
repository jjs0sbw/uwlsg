variable "domain" {
  default = "adriennecohea.ninja"
}

variable "ssh_keys" {
  default = [7172020, 7172181]
}

variable "counts" {
  type = "map"

  default = {
    "compute" = 4
    "control" = 3
  }
}

variable "control_size" {
  default = "s-2vcpu-2gb"
}

variable "compute_size" {
  default = "s-4vcpu-8gb"
}
