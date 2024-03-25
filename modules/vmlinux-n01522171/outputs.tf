output "availability_set" {
  value = azurerm_availability_set.rg-aset.name
}

output "vm_hostname" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].name
}

output "vm_fqdn" {
  value = values(azurerm_public_ip.pub-ip)[*].fqdn
}
output "vm_ids" {
  value = { for vm_name, vm in azurerm_linux_virtual_machine.vmlinux : vm_name => vm.id }
}

output "nic_ids" {
  value = values(azurerm_network_interface.linux-nic)[*].id
}

output "pvt_ip_addr" {
  value = values(azurerm_network_interface.linux-nic)[*].private_ip_address
}

output "pub_ip_addr" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].public_ip_address
}
