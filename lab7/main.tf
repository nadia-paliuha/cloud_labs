terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "rg" {
  name     = var.group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_storage_container" "data_container" {
  name                  = "data"
  storage_account_name = azurerm_storage_account.main_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container_immutability_policy" "data_policy" {
  storage_container_resource_manager_id = azurerm_storage_container.data_container.resource_manager_id
  immutability_period_in_days           = 180
}

resource "azurerm_storage_management_policy" "storage_lifecycle" {
  storage_account_id = azurerm_storage_account.main_storage.id

  rule {
    name    = "Movetocool"
    enabled = true

    filters {
      blob_types   = ["blockBlob"]
      prefix_match = [""]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = 30
      }
    }
  }
}

resource "azurerm_storage_share" "share1" {
  name                 = "share1"
  storage_account_name = azurerm_storage_account.main_storage.name
  quota                = 100
  access_tier          = "TransactionOptimized"

  depends_on = [azurerm_storage_account.main_storage]
}
