resource "azurerm_management_group" "lab_mg" {
  name         = "az104-mg1"
  display_name = "az104-mg1"
}

resource "azuread_group" "helpdesk" {
  display_name     = var.helpdesk_group_name
  mail_enabled     = false
  security_enabled = true
}
