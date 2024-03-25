locals {
  common_tags = {
    Name         = "Terraform-Class"
    Project      = "Learning"
    ContactEmail = "n01522171@humber.ca"
    Environment  = "Lab"
  }
}

variable "network_rg" {}

variable "location" {}

variable "subnet1_id" {}

variable "linux_avs" {}

variable "nb_count" {}


variable "linux_names" {}

variable "size" {}

variable "boot_diagnostics_strg_acc" {}

variable "admin_username" {
  default = "imrit"
}

variable "priv_key" {
  default = "/home/imrit/.ssh/id_rsa"
}

variable "public_key" {
  default = "/home/imrit/.ssh/id_rsa.pub"
}

variable "OS_disk_attr" {
  type = map(string)
  default = {
    OS_Storage_account_type = "Premium_LRS"
    OS_Disk_size            = "32"
    OS_Caching              = "ReadWrite"
  }
}

variable "Linux_publisher" {}

variable "Linux_offer" {}

variable "Linux_Sku" {}

variable "Linux_version" {}