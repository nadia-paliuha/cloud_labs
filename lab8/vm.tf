resource "azurerm_public_ip" "vm1_pip" {
  name                = "az104-vm1-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip" "vm2_pip" {
  name                = "az104-vm2-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["2"]
}

resource "azurerm_network_interface" "nic_vm1" {
  name                = "vm1-nic"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm1_pip.id
  }
}

resource "azurerm_network_interface" "nic_vm2" {
  name                = "vm2-nic"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm2_pip.id
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "az104-vm1"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_password      = var.admin_password
  admin_username      = var.admin_name
  size                = var.size_vm

  network_interface_ids = [
    azurerm_network_interface.nic_vm1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  patch_assessment_mode = "AutomaticByPlatform"
  patch_mode            = "AutomaticByPlatform"

  boot_diagnostics {
    storage_account_uri = null
  }
  depends_on = [
    azurerm_network_interface.nic_vm1,
    azurerm_public_ip.vm1_pip
  ]
}

resource "azurerm_windows_virtual_machine" "vm2" {
  name                = "az104-vm2"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_password      = var.admin_password
  admin_username      = var.admin_name
  size                = var.size_vm

  network_interface_ids = [
    azurerm_network_interface.nic_vm2.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  patch_assessment_mode = "AutomaticByPlatform"
  patch_mode            = "AutomaticByPlatform"

  boot_diagnostics {
    storage_account_uri = null
  }

  depends_on = [
    azurerm_network_interface.nic_vm2,
    azurerm_public_ip.vm2_pip
  ]
}

resource "azurerm_managed_disk" "disk1" {
  name                 = "vm1-disk1"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name

  create_option        = "Empty"
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb = 32
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm1_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.disk1.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm1.id
  lun                = 0
  caching            = "ReadWrite"
}