output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = azurerm_resource_group.lab_rg.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.my_test_stg.name
}

output "lock_id" {
  description = "The ID of the resource lock"
  value       = azurerm_management_lock.rg_lock.id
}
