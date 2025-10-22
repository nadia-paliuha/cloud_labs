resource "azurerm_role_assignment" "vm_contributor" {
  scope                = azurerm_management_group.lab_mg.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azuread_group.helpdesk.object_id  # <- саме так
}

resource "azurerm_role_definition" "custom_support_request" {
  name        = "Custom Support Request"
  scope       = azurerm_management_group.lab_mg.id
  description = "A custom contributor role for support requests"

  permissions {
    actions     = [
      "Microsoft.Compute/virtualMachines/*",
      "Microsoft.Support/*/read",
      "Microsoft.Support/supportTickets/*"
    ]
    not_actions = [
      "Microsoft.Support/register/action"
    ]
  }

  assignable_scopes = [
    azurerm_management_group.lab_mg.id
  ]
}

resource "azurerm_role_assignment" "custom_support_assignment" {
  scope                = azurerm_management_group.lab_mg.id
  role_definition_name = azurerm_role_definition.custom_support_request.name
  principal_id         = azuread_group.helpdesk.object_id  # <- правильно
}

