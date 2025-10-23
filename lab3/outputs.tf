output "resource_group_name" {
  value = "azurerm_resource_group.rg.name"
  description = "Resource Group Name"
}

output "id_disk1" {
  value = "azurerm_managed_disk.disk1.id"
  description = "Id Disk1"
}

output "id_disk2" {
  value = "azurerm_managed_disk.disk2.id"
  description = "Id Disk2"
}

output "id_disk3" {
  value = "azurerm_managed_disk.disk3.id"
  description = "Id Disk3"
}

output "id_disk4" {
  value = "azurerm_managed_disk.disk4.id"
  description = "Id Disk4"
}

output "id_disk5" {
  value = "azurerm_managed_disk.disk5.id"
  description = "Id Disk5"
}

output "all_disk_id" {
  value = {
    disk1 = azurerm_managed_disk.disk1.id
    disk2 = azurerm_managed_disk.disk2.id
    disk3 = azurerm_managed_disk.disk3.id
    disk4 = azurerm_managed_disk.disk4.id
    disk5 = azurerm_managed_disk.disk5.id
  }
}