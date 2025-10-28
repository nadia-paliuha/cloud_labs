resource "azurerm_storage_account" "main_storage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }

    versioning_enabled = false
  }

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
    ip_rules                   = [var.client_ip]
    bypass                     = ["AzureServices"]
  }

  tags = {
    environment = "Lab7"
  }
}