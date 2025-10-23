terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
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

resource "azurerm_virtual_network" "core_net" {
  name                = "CoreServicesVnet"
  address_space       = ["10.20.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "shared_subnet" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.core_net.name
  address_prefixes     = ["10.20.10.0/24"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "DatabaseSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.core_net.name
  address_prefixes     = ["10.20.20.0/24"]
}

resource "azurerm_virtual_network" "manufactur_net" {
  name                = "ManufacturingVnet"
  address_space       = ["10.30.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "SensorSubnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.manufactur_net.name
  address_prefixes     = ["10.30.20.0/24"]
}

resource "azurerm_subnet" "subnet_2" {
  name                 = "SensorSubnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.manufactur_net.name
  address_prefixes     = ["10.30.21.0/24"]
}


