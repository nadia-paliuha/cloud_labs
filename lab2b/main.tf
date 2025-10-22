terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "lab_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    "Cost Center" = var.cost_center_value
  }
}

#data "azurerm_policy_definition" "require_tag" {
#  display_name = "Require a tag and its value on resources"
#}

#resource "azurerm_resource_group_policy_assignment" "require_tag_assignment" {
#  name                 = "require-cost-center-tag"
#  resource_group_id    = azurerm_resource_group.lab_rg.id
#  location             = var.location
# policy_definition_id = data.azurerm_policy_definition.require_tag.id
#  display_name         = "Require Cost Center tag and its value on resources"
# description          = "Require Cost Center tag and its value on all resources in the resource group"

#  parameters = jsonencode({
#    tagName  = { value = "Cost Center" }
#    tagValue = { value = "000" }
#  })

#}

data "azurerm_policy_definition" "inherit_tag" {
  display_name = "Inherit a tag from the resource group if missing"
}

resource "azurerm_resource_group_policy_assignment" "inherit_tag_assignment" {
  name                 = "inherit-cost-center-tag"
  resource_group_id    = azurerm_resource_group.lab_rg.id
  policy_definition_id = data.azurerm_policy_definition.inherit_tag.id
  display_name         = "Inherit the Cost Center tag and its value from the resource group if missing"
  description          = "Inherit the Cost Center tag and its value from the resource group if missing"

  parameters = jsonencode({
    tagName = { value = "Cost Center" }
  })

  identity {
    type = "SystemAssigned"
  }

  location = var.location

  depends_on = [
    azurerm_resource_group.lab_rg
  ]
}



resource "azurerm_resource_policy_remediation" "inherit_tag" {
  name                  = "remediate-cc-tag"
  resource_id           = azurerm_resource_group.lab_rg.id
  policy_assignment_id  = azurerm_resource_group_policy_assignment.inherit_tag_assignment.id
  resource_discovery_mode = "ReEvaluateCompliance"

  depends_on = [azurerm_resource_group_policy_assignment.inherit_tag_assignment]
}

resource "azurerm_management_lock" "rg_lock" {
  name       = "rg-lock"
  scope      = azurerm_resource_group.lab_rg.id
  lock_level = "CanNotDelete"
  notes      = "Protect resource group from accidental deletion"
}
