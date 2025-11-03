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

resource "azurerm_resource_group" "rg_1" {
  name     = var.group_name1
  location = var.location_region1
}

resource "azurerm_resource_group" "rg_2" {
  name     = var.group_name2
  location = var.location_region2
}

resource "azurerm_public_ip" "pip_10" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg_1.location
  name                = "az104-pip-10"
  resource_group_name = azurerm_resource_group.rg_1.name
  sku                 = "Standard"
}

resource "azurerm_recovery_services_vault" "rsv_region1" {
  name                = "az104-rsv-region1"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name
  sku                 = "Standard"
  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "backup" {
  name                = "az104-policy"
  recovery_vault_name = azurerm_recovery_services_vault.rsv_region1.name
  resource_group_name = azurerm_resource_group.rg_1.name
  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "00:00"
  }

  retention_daily {
    count = 7
  }

  instant_restore_retention_days = 2
}

resource "azurerm_storage_account" "monitor" {
  name                     = var.storage_name_1
  account_replication_type = "LRS"
  account_tier             = "Standard"

  location                 = azurerm_resource_group.rg_1.location
  resource_group_name      = azurerm_resource_group.rg_1.name
}

resource "azurerm_recovery_services_vault" "rsv_region2" {
  name                = "az104-rsv-region2"

  location            = azurerm_resource_group.rg_2.location
  resource_group_name = azurerm_resource_group.rg_2.name
  sku                 = "Standard"
  soft_delete_enabled = true
}