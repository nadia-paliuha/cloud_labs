output "webapp_name" {
  value       = azurerm_linux_web_app.webapp.name
  description = "Name of the production Linux Web App"
}

output "webapp_default_hostname" {
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
  description = "Default domain of the production Web App"
}

output "staging_slot_name" {
  value       = azurerm_linux_web_app_slot.staging.name
  description = "Name of the staging slot"
}

output "staging_slot_default_hostname" {
  value       = "https://${azurerm_linux_web_app_slot.staging.default_hostname}"
  description = "Default domain of the staging slot"
}

output "service_plan_name" {
  value       = azurerm_service_plan.service_plan.name
  description = "Name of the App Service Plan"
}

output "service_plan_id" {
  value       = azurerm_service_plan.service_plan.id
  description = "Id of the App Service Plan"
}
