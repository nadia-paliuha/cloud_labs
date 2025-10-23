output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "core_vnet_id" {
  value = azurerm_virtual_network.core_net.id
}

output "core_vnet_name" {
  value = azurerm_virtual_network.core_net.name
}

output "shared_services_subnet_id" {
  value = azurerm_subnet.shared_subnet.id
}

output "database_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}

output "manufacturing_vnet_id" {
  value = azurerm_virtual_network.manufactur_net.id
}

output "sensor_subnet1_id" {
  value = azurerm_subnet.subnet_1.id
}

output "sensor_subnet2_id" {
  value = azurerm_subnet.subnet_2.id
}

output "nsg_secure_id" {
  value = azurerm_network_security_group.nsg_secure.id
}

output "asg_web_id" {
  value = azurerm_application_security_group.asg_web.id
}

output "public_dns_zone_id" {
  value = azurerm_dns_zone.public.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.private.id
}
