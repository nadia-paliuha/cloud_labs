output "core_vm_private_ip" {
  value = azurerm_network_interface.core_services_nic.private_ip_address
}

output "manufacturing_vm_private_ip" {
  value = azurerm_network_interface.manufacturing_nic.private_ip_address
}

output "core_vnet_id" {
  value = azurerm_virtual_network.core_services.id
}

output "manufacturing_vnet_id" {
  value = azurerm_virtual_network.manufacturing.id
}

output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of the resource group"
}
