output "log_analytics_name" {
  value = azurerm_log_analytics_workspace.n01522171-log-analytics.name
}

output "recover_vault_name" {
  value = azurerm_recovery_services_vault.n01522171-vault.name
}

output "storageaccount_name" {
  value = azurerm_storage_account.n01522171storageaccount.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.n01522171storageaccount.primary_blob_endpoint
}