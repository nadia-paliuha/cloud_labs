output "container_name" {
  value = azurerm_container_group.aci.name
  description = "Name of container instance"
}

output "container_ip" {
  value = azurerm_container_group.aci.ip_address
  description = "Public Ip of container"
}

output "container_fqdn" {
  value = azurerm_container_group.aci.fqdn
  description = "FQDN of container"
}