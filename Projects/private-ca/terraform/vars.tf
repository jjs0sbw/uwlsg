variable "domain" {
  default = "adriennecohea.ninja"
}

variable "counts" {
  type = "map"

  default = {
    "compute" = 4
    "control" = 3
  }
}
