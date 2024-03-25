
resource "azurerm_log_analytics_workspace" "n01522171-log-analytics" {
  name                = var.log-analytics
  location            = var.location
  resource_group_name = var.network_rg
  sku                 = var.loganalyticsku
  retention_in_days   = var.retentiondays
}

resource "azurerm_recovery_services_vault" "n01522171-vault" {
  name                = var.recovery-vault
  location            = var.location
  resource_group_name = var.network_rg
  sku                 = var.recoveryvaultsku

  soft_delete_enabled = var.sdoption
}

resource "azurerm_storage_account" "n01522171storageaccount" {
  name                     = var.storageaccountname
  resource_group_name      = var.network_rg
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replicn_type
  

  tags = {
    environment = "learning"
  }
}