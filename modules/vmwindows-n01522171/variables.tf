variable "windows_avs" {}

variable "network_rg" {}

locals {
  common_tags = {
    Name         = "Terraform-Class"
    Project      = "Learning"
    ContactEmail = "n01522171@humber.ca"
    Environment  = "Lab"
  }
}

variable "boot_diagnostics_strg_acc" {}

variable "size" {}

variable "nb_count_win" {}

variable "windows_name" {}

variable "subnet1_id" {}

variable "location" {}

variable "admin_username_win" {
  default = "imrit"
}

variable "admin_password" {
  default = "Imr1t!2345678"
}

variable "OS_disk_attr_win" {
  type = map(string)
  default = {
    OS_Storage_account_type = "StandardSSD_LRS"
    OS_Disk_size            = "128"
    OS_Caching              = "ReadWrite"
  }
}

variable "Windows_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "Windows_offer" {
  default = "WindowsServer"
}

variable "Windows_sku" {
  default = "2019-Datacenter"
}

variable "Windows_version" {
  default = "latest"
}
