output "resource_group_name" {
  value = module.rgroup-n01522171.n01522171-RG

}

output "virtual_network_name" {
  value = module.network-n01522171.virtual_nw_name
}

output "address_space" {
  value = module.network-n01522171.virtual_nw_addr_space
}

output "subnet_name" {
  value = module.network-n01522171.subnet_name_1
}

output "subnet_address" {
  value = module.network-n01522171.subnet_addr_space_1
}

output "network_nsg_name" {
  value = module.network-n01522171.network_security_group1_name
}

output "log_analytics_name" {
  value = module.common-n01522171.log_analytics_name
}

output "recover_vault_name" {
  value = module.common-n01522171.recover_vault_name
}

output "storageaccount_name" {
  value = module.common-n01522171.storageaccount_name
}

output "linux-hostname" {
  value = module.vmlinux-n01522171.vm_hostname
}

output "linux-domin_name" {
  value = module.vmlinux-n01522171.vm_fqdn

}

output "linux-private_ip_address" {
  value = module.vmlinux-n01522171.pub_ip_addr
}
output "linux-public_ip_address" {
  value = module.vmlinux-n01522171.pvt_ip_addr

}

output "vmwindows_hostname" {
  value = module.vmwindows-n01522171.vm_hostname_win
}

output "vmwindows_pvt_ip_addr" {
  value = module.vmwindows-n01522171.pvt_ip_addr_win
}

output "vmwindows_pub_ip_addr" {
  value = module.vmwindows-n01522171.pub_ip_addr_win

}

output "loadbalancer_name" {
  value = module.loadbalancer-n01522171.loadbalancer

}

output "database_name" {
  value = module.database-n01522171.db_name

}