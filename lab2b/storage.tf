resource "random_string" "my_test_suffix" {
  length  = 5
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_storage_account" "my_test_stg" {
  name                     = "myteststg${random_string.my_test_suffix.result}"
  resource_group_name      = azurerm_resource_group.lab_rg.name
  location                 = azurerm_resource_group.lab_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  depends_on = [
    azurerm_resource_group_policy_assignment.inherit_tag_assignment,
    azurerm_resource_policy_remediation.inherit_tag
  ]
}