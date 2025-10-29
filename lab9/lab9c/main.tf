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

resource "azurerm_log_analytics_workspace" "log_analyst" {
  name                = "my-log-analytics-workspace"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_container_app_environment" "container_env" {
  name                        = "my-environment"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.log_analyst.id
}

resource "azurerm_container_app" "app" {
  name                         = "my-application"

  container_app_environment_id = azurerm_container_app_environment.container_env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    container {
      cpu    = 0.25
      image  = var.image
      memory = "0.5Gi"
      name   = "my-container"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}