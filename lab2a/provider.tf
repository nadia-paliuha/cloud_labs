terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.47"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.6"
    }
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret

  features {}
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}


data "azurerm_client_config" "current" {}
