output "container_app_environment_name" {
  value       = azurerm_container_app_environment.container_env.name
  description = "Name of Container Apps"
}

# ID середовища
output "container_app_environment_id" {
  value       = azurerm_container_app_environment.container_env.id
  description = "Id of Container Apps"
}

output "container_app_url" {
  value       = azurerm_container_app.app.ingress[0].fqdn
  description = "URL to access Container App"
}