resource "azurerm_network_interface" "linux-nic" {
  for_each =                  var.linux_names
  name = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.network_rg
  tags                = local.common_tags

  ip_configuration {
    name                          = "${each.value}-ipconfig"
    subnet_id                     = var.subnet1_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub-ip[each.key].id
  }
}

resource "azurerm_availability_set" "rg-aset" {
  name                         = "rg-aset"
  location                     = var.location
  resource_group_name          = var.network_rg
  platform_update_domain_count = 5
  platform_fault_domain_count  = 2
}

resource "azurerm_public_ip" "pub-ip" {
  for_each            = var.linux_names
  name                = "${each.value}-pip"
  location            = var.location
  resource_group_name = var.network_rg
  allocation_method   = "Dynamic"
  domain_name_label   = "${each.value}"
  tags                = local.common_tags
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each                 = var.linux_names
  name                  = "${each.value}"
  computer_name         = "${each.value}"
  location              = var.location
  resource_group_name   = var.network_rg
  size                  = var.size
  admin_username        = var.admin_username
  tags                  = local.common_tags
  availability_set_id = azurerm_availability_set.rg-aset.id
  network_interface_ids = [azurerm_network_interface.linux-nic[each.key].id]


  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  os_disk {
    name                 = "${each.value}-os-disk"
    caching              = var.OS_disk_attr["OS_Caching"]
    storage_account_type = var.OS_disk_attr["OS_Storage_account_type"]
    disk_size_gb         = var.OS_disk_attr["OS_Disk_size"]
  }

  source_image_reference {
    publisher = var.Linux_publisher
    offer     = var.Linux_offer
    sku       = var.Linux_Sku
    version   = var.Linux_version
  }
  lifecycle {
    ignore_changes = [tags, ]
  }
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_strg_acc
  }
}



resource "azurerm_virtual_machine_extension" "NetworkWatcherAgentLinux" {
  for_each                 = var.linux_names
  name                 = "${each.key}-NetworkWatcherAgentLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "AzureMonitorLinuxAgent" {
  for_each                 = var.linux_names
  name                 = "${each.key}-AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.29"

}

