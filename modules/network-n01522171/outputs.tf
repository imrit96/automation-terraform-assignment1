output "virtual_nw_name" {
  value = azurerm_virtual_network.n01522171-VNET.name
}

output "virtual_nw_addr_space" {
  value = azurerm_virtual_network.n01522171-VNET.address_space
}

output "subnet_name_1" {
  value = azurerm_subnet.n01522171-SUBNET.name
}

output "subnet1_id" {
  value = azurerm_subnet.n01522171-SUBNET.id
}

output "subnet_addr_space_1" {
  value = azurerm_subnet.n01522171-SUBNET.address_prefixes
}

output "network_security_group1_name" {
  value = azurerm_network_security_group.n01522171-nsg.name
}