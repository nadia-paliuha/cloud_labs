output "storage_account_name" {
  value = azurerm_storage_account.main_storage.name
}

output "container_name" {
  value = azurerm_storage_container.data_container.name
}

output "file_share_name" {
  value = azurerm_storage_share.share1.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
