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
