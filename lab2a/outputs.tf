output "management_group_id" {
  value = azurerm_management_group.lab_mg.id
}

output "helpdesk_group_id" {
  value = azuread_group.helpdesk.id
}

output "custom_role_id" {
  value = azurerm_role_definition.custom_support_request.id
}
