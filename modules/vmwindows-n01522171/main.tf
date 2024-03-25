resource "azurerm_network_interface" "windows-nic" {
  count               = var.nb_count_win
  name                = "${var.windows_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.network_rg
  tags                = local.common_tags

  ip_configuration {
    name                          = "${var.windows_name}-nic-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet1_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.pub-ip-win[*].id, count.index + 1)
  }
}

resource "azurerm_availability_set" "rg-aset-w" {
  name                         = "rg-aset-w"
  location                     = var.location
  resource_group_name          = var.network_rg
  platform_update_domain_count = 5
  platform_fault_domain_count  = 2
}

resource "azurerm_public_ip" "pub-ip-win" {
  count               = var.nb_count_win
  name                = "${var.windows_name}-pubip-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.network_rg
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.windows_name}-pubip-${format("%1d", count.index + 1)}"
  tags                = local.common_tags
}

resource "azurerm_windows_virtual_machine" "vmwindows" {
  count               = var.nb_count_win
  name                  = "${var.windows_name}-${format("%1d", count.index + 1)}"
  computer_name         = "${var.windows_name}-${format("%1d", count.index + 1)}"
  location              = var.location
  resource_group_name   = var.network_rg
  size = var.size
  admin_username        = var.admin_username_win
  admin_password        = var.admin_password
  tags                  = local.common_tags
  network_interface_ids = [azurerm_network_interface.windows-nic[count.index].id]
  
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_strg_acc
  }

  os_disk {
    name              = "${var.windows_name}${format("%1d", count.index+1)}-osdisk"
    caching              = var.OS_disk_attr_win["OS_Caching"]
    storage_account_type = var.OS_disk_attr_win["OS_Storage_account_type"]
    disk_size_gb         = var.OS_disk_attr_win["OS_Disk_size"]
  }

  source_image_reference {
    publisher = var.Windows_publisher
    offer     = var.Windows_offer
    sku       = var.Windows_sku
    version   = var.Windows_version
  }
  lifecycle {
    ignore_changes = [tags, ]
  }
}