variable "linux_vm_ids" {
  type    = list(string)
  description = "List of Linux VM IDs to attach data disks to"
}


variable "network_rg" {
  description = "Name of the resource group"
}

variable "location" {}


variable "windows_vm_id" {
  type        = list(string)
  description = "Windows VM ID to attach data disks to"
}

variable "vmlinux" {}

variable "vmwindows" {}
