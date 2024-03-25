output "availability_set_win" {
  value = azurerm_availability_set.rg-aset-w.name
}

output "vm_hostname_win" {
  value = azurerm_windows_virtual_machine.vmwindows[*].name
}

output "vm_ids" {
    value = azurerm_windows_virtual_machine.vmwindows[*].id
  
}

output "pvt_ip_addr_win" {
  value = azurerm_network_interface.windows-nic[*].private_ip_address
}

output "pub_ip_addr_win" {
  value = azurerm_windows_virtual_machine.vmwindows[*].public_ip_address
}
