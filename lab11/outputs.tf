output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "network_security_group_id" {
  description = "ID of the Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}

output "public_ip_address" {
  description = "Public IP"
  value = azurerm_public_ip.pip.ip_address
}

output "nic_id" {
  description = "NIC id"
  value = azurerm_network_interface.nic.id
}

output "vm_id" {
  description = "Id of Vm"
  value = azurerm_windows_virtual_machine.vm.id
}

output "storage_account_name" {
  description = "Storage account name for VM diagnostics"
  value       = azurerm_storage_account.storage.name
}
