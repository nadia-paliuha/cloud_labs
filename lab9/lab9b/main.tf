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
  location = var.location
  name     = var.group_name
}

resource "azurerm_container_group" "aci" {
  name                = "az104-c1"
  os_type             = "Linux"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type = "Public"
  dns_name_label = var.dns_name_label

  container {
    name = "container-lab9b"
    cpu = 1
    memory = 1.5
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
}