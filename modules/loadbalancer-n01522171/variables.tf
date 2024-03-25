variable "network_rg" {}

variable "location" {}

variable "loadbalancer-name" {}

variable "linux-nic-id" {
  type = list(string)
}

variable "linux-vm-name" {}

variable "nb_count" {
  default = 1
}

