module "rgroup-n01522171" {
  source     = "./modules/rgroup-n01522171"
  network_rg = "network_rg"
  location   = "UK West"

}

module "network-n01522171" {
  source       = "./modules/network-n01522171"
  location     = "UK West"
  network_rg   = "network_rg"
  subnet       = "n01522171-SUBNET"
  nsg          = "n01522171-nsg"
  vnet         = "n01522171-VNET"
  vnet_space   = ["10.0.0.0/16"]
  subnet_space = ["10.0.0.0/24"]
  depends_on   = [module.rgroup-n01522171]
}

module "common-n01522171" {
  source               = "./modules/common-n01522171"
  location             = "UK West"
  network_rg           = "network_rg"
  log-analytics        = "n01522171-log-analytics"
  loganalyticsku       = "PerGB2018"
  retentiondays        = 30
  recovery-vault       = "n01522171-vault"
  recoveryvaultsku     = "Standard"
  sdoption             = true
  storageaccountname   = "n01522171storageaccount"
  account_replicn_type = "GRS"
  account_tier         = "Standard"
  depends_on           = [module.rgroup-n01522171]

}

module "vmlinux-n01522171" {
  source = "./modules/vmlinux-n01522171"
  linux_names = {
    "vm1" = "n01526950-cs-vm1"
    "vm2" = "n01526950-cs-vm2"
    "vm3" = "n01526950-cs-vm3"
  }
  location                  = "UK West"
  network_rg                = "network_rg"
  subnet1_id                = module.network-n01522171.subnet1_id
  linux_avs                 = "linux_avs"
  nb_count                  = "2"
  size                      = "Standard_B1s"
  Linux_publisher           = "OpenLogic"
  Linux_offer               = "CentOS"
  Linux_Sku                 = "8_2"
  Linux_version             = "latest"
  boot_diagnostics_strg_acc = module.common-n01522171.primary_blob_endpoint
  depends_on                = [module.rgroup-n01522171]
}

module "vmwindows-n01522171" {
  source                    = "./modules/vmwindows-n01522171"
  location                  = "UK West"
  network_rg                = "network_rg"
  subnet1_id                = module.network-n01522171.subnet1_id
  windows_avs               = "windowsAvailabilitySet"
  windows_name              = "n01522171-win"
  boot_diagnostics_strg_acc = module.common-n01522171.primary_blob_endpoint
  nb_count_win              = "1"
  size                      = "Standard_DS1_v2"
  depends_on                = [module.rgroup-n01522171]
}

module "datadisk-n01522171" {
  source        = "./modules/datadisk-n01522171"
  location      = "UK West"
  network_rg    = "network_rg"
  linux_vm_ids  = values(module.vmlinux-n01522171.vm_ids)
  windows_vm_id = module.vmwindows-n01522171.vm_ids
  vmlinux       = module.vmlinux-n01522171.vm_hostname
  vmwindows     = module.vmwindows-n01522171.vm_hostname_win
}

module "loadbalancer-n01522171" {
  source            = "./modules/loadbalancer-n01522171"
  location          = "UK West"
  network_rg        = "network_rg"
  loadbalancer-name = "n01522171-LOADBALANCER"
  linux-nic-id      = module.vmlinux-n01522171.nic_ids
  linux-vm-name     = module.vmlinux-n01522171.vm_hostname
  depends_on        = [module.rgroup-n01522171]

}

module "database-n01522171" {
  source     = "./modules/database-n01522171"
  location   = "UK West"
  network_rg = "network_rg"
  db_name    = "n01522171-database"
  depends_on = [module.rgroup-n01522171]
}

