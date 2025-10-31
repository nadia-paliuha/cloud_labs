output "vm_name" {
  description = "Name of the Windows VM"
  value       = azurerm_windows_virtual_machine.vm.name
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.pip_10.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "recovery_vault_name_1" {
  description = "Name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.rsv_region1.name
}

output "recovery_vault_region_1" {
  description = "Region of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.rsv_region1.location
}

output "recovery_vault_name_2" {
  description = "Name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.rsv_region2.name
}

output "recovery_vault_region_2" {
  description = "Region of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.rsv_region2.location
}

output "storage_account_name" {
  description = "Name of the storage account used for monitoring logs"
  value       = azurerm_storage_account.monitor.name
}

