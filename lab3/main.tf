terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
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
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_managed_disk" "disk1" {
  name                 = "az104-disk1"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_managed_disk" "disk2" {
  name                 = "az104-disk2"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_managed_disk" "disk3" {
  name                 = "az104-disk3"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_managed_disk" "disk4" {
  name                 = "az104-disk4"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_managed_disk" "disk5" {
  name                 = "az104-disk5"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}
