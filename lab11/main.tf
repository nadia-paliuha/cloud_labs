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

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "az104-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.size_vm
  admin_username      = var.admin_name
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage.primary_blob_endpoint
  }
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "az104-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_action_group" "action_group" {
  name                = "AlertOpsTeam"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "AlertOps"

  email_receiver {
    name                   = "VMDeletedEmail"
    email_address          = var.email
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_activity_log_alert" "log_del" {
  name                = "VMDeletedAlert"
  location = "Global"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_resource_group.rg.id]
  description         = "A VM in your resource group was deleted"
  criteria {
    category = "Administrative"
    operation_name = "Microsoft.Compute/virtualMachines/delete"
    status = "Succeeded"
  }
  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }
}