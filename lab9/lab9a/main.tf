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

resource "azurerm_service_plan" "service_plan" {
  name                = "az104-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "az104-webapp-unique14"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    application_stack {
      php_version = "8.2"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

resource "azurerm_linux_web_app_slot" "staging" {
  name                = "staging"
  app_service_id = azurerm_linux_web_app.webapp.id

  site_config {
    application_stack {
      php_version = "8.2"
    }
    always_on = true
  }
}

resource "azurerm_app_service_source_control_slot" "staging_cd" {
  slot_id = azurerm_linux_web_app_slot.staging.id
  branch     = "master"
  repo_url   = "https://github.com/Azure-Samples/php-docs-hello-world"
  use_manual_integration = true
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "az104-webapp-unique14-autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  target_resource_id  = azurerm_service_plan.service_plan.id

  profile {
    name     = "defaultProfile"
    capacity {
      default = 1
      minimum = 1
      maximum = 2
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.service_plan.id
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 75
        time_grain         = "PT1M"
        time_window        = "PT5M"
        time_aggregation   = "Average"
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.service_plan.id
        operator           = "LessThan"
        statistic          = "Average"
        threshold          = 30
        time_grain         = "PT1M"
        time_window        = "PT5M"
        time_aggregation   = "Average"
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}
