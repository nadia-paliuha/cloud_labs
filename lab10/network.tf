resource "azurerm_virtual_network" "vnet" {
  address_space = ["10.0.0.0/16"]
  name                = "az104-vnet"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name
}

resource "azurerm_subnet" "subnet" {
  address_prefixes = ["10.0.1.0/24"]
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg_1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg_10" {
  name                = "az104-nsg-10"

  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name

  security_rule {
    name                       = "allow-rdp"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "az104-nic"
  location            = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.pip_10.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg_10.id

  depends_on = [
    azurerm_network_interface.nic,
    azurerm_network_security_group.nsg_10
  ]
}