terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
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

resource "azurerm_virtual_network" "vnet" {
  name                = "az104-06-vnet1"
  address_space       = ["10.60.0.0/22"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.60.0.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.60.1.0/24"]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.60.2.0/24"]
}

resource "azurerm_subnet" "subnet_appgw" {
  name                 = "subnet-appgw"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.60.3.224/27"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "az104-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-rdp"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic_vm0" {
  name                = "az104-06-nic0"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.60.0.4"
  }
}

resource "azurerm_network_interface" "nic_vm1" {
  name                = "az104-06-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.60.1.4"
  }
}

resource "azurerm_network_interface" "nic_vm2" {
  name                = "az104-06-nic2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet3.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.60.2.4"
  }
}

resource "azurerm_network_interface_security_group_association" "nic0_nsg" {
  network_interface_id      = azurerm_network_interface.nic_vm0.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_network_interface_security_group_association" "nic1_nsg" {
  network_interface_id      = azurerm_network_interface.nic_vm1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_network_interface_security_group_association" "nic2_nsg" {
  network_interface_id      = azurerm_network_interface.nic_vm2.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_windows_virtual_machine" "vm0" {
  name                  = "az104-06-vm0"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.size_vm
  admin_username        = var.admin_name
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_vm0.id]

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

resource "azurerm_windows_virtual_machine" "vm1" {
  name                  = "az104-06-vm1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.size_vm
  admin_username        = var.admin_name
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_vm1.id]

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

resource "azurerm_windows_virtual_machine" "vm2" {
  name                  = "az104-06-vm2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.size_vm
  admin_username        = var.admin_name
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_vm2.id]

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

resource "azurerm_virtual_machine_extension" "vm0_iis" {
  name                 = "customScriptExtension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm0.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
{
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -name Web-Server -IncludeManagementTools; Remove-Item -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -ErrorAction SilentlyContinue; Set-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value ('Hello World from ' + $env:COMPUTERNAME)\""
}
SETTINGS
}

resource "azurerm_virtual_machine_extension" "vm1_iis" {
  name                 = "customScriptExtension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
{
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -name Web-Server -IncludeManagementTools; Remove-Item -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -ErrorAction SilentlyContinue; Set-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value ('Hello World from ' + $env:COMPUTERNAME); New-Item -Path 'C:\\inetpub\\wwwroot\\image' -ItemType Directory -Force; Set-Content -Path 'C:\\inetpub\\wwwroot\\image\\iisstart.htm' -Value ('Image from: ' + $env:COMPUTERNAME)\""
}
SETTINGS
}

resource "azurerm_virtual_machine_extension" "vm2_iis" {
  name                 = "customScriptExtension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
{
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -name Web-Server -IncludeManagementTools; Remove-Item -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -ErrorAction SilentlyContinue; Set-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value ('Hello World from ' + $env:COMPUTERNAME); New-Item -Path 'C:\\inetpub\\wwwroot\\video' -ItemType Directory -Force; Set-Content -Path 'C:\\inetpub\\wwwroot\\video\\iisstart.htm' -Value ('Video from: ' + $env:COMPUTERNAME)\""
}
SETTINGS
}

resource "azurerm_public_ip" "lb_pip" {
  name                = "az104-lbpip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = "az104-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "az104-fe"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_be" {
  name            = "az104-be"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "assoc_vm0" {
  network_interface_id    = azurerm_network_interface.nic_vm0.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_be.id
}

resource "azurerm_network_interface_backend_address_pool_association" "assoc_vm1" {
  network_interface_id    = azurerm_network_interface.nic_vm1.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_be.id
}

resource "azurerm_lb_probe" "lb_probe" {
  name                = "az104-hp"
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "az104-lbrule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "az104-fe"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_be.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
  idle_timeout_in_minutes        = 4
  enable_tcp_reset               = false
  disable_outbound_snat          = false
}

resource "azurerm_public_ip" "appgw_pip" {
  name                = "az104-gwpip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_application_gateway" "appgw" {
  name                = "az104-appgw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.subnet_appgw.id
  }

  frontend_ip_configuration {
    name                 = "az104-fe"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  backend_address_pool {
    name = "az104-appgwbe"
    ip_addresses = [
      azurerm_network_interface.nic_vm1.private_ip_address,
      azurerm_network_interface.nic_vm2.private_ip_address
    ]
  }

  backend_address_pool {
    name = "az104-imagebe"
    ip_addresses = [
      azurerm_network_interface.nic_vm1.private_ip_address
    ]
  }

  backend_address_pool {
    name = "az104-videobe"
    ip_addresses = [
      azurerm_network_interface.nic_vm2.private_ip_address
    ]
  }

  backend_http_settings {
    name                  = "az104-http"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "az104-listener"
    frontend_ip_configuration_name = "az104-fe"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  url_path_map {
    name                               = "az104-pathmap"
    default_backend_address_pool_name  = "az104-appgwbe"
    default_backend_http_settings_name = "az104-http"

    path_rule {
      name                       = "images"
      paths                      = ["/image/*"]
      backend_address_pool_name  = "az104-imagebe"
      backend_http_settings_name = "az104-http"
    }

    path_rule {
      name                       = "videos"
      paths                      = ["/video/*"]
      backend_address_pool_name  = "az104-videobe"
      backend_http_settings_name = "az104-http"
    }
  }

  request_routing_rule {
    name               = "az104-gwrule"
    rule_type          = "PathBasedRouting"
    http_listener_name = "az104-listener"
    url_path_map_name  = "az104-pathmap"
    priority           = 10
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  depends_on = [
    azurerm_windows_virtual_machine.vm0,
    azurerm_windows_virtual_machine.vm1,
    azurerm_windows_virtual_machine.vm2
  ]
}
