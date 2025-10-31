resource "azurerm_windows_virtual_machine" "vm" {
  name                = "az104-vm10"

  network_interface_ids = [azurerm_network_interface.nic.id]
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name
  admin_password      = var.admin_password
  admin_username      = var.admin_name
  size                = var.size_vm

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
}