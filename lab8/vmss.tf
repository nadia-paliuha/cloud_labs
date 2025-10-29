resource "azurerm_network_security_group" "vm1_nsg" {
  name                = "vmss1-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "vmss_lb_pip" {
  name                = "vmss-lb-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "vmss_lb" {
  name                = "vmss-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontendIp"
    public_ip_address_id = azurerm_public_ip.vmss_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "vmss_lb_backend" {
  name                = "vmss-lb-backend"
  loadbalancer_id     = azurerm_lb.vmss_lb.id

  depends_on = [azurerm_lb.vmss_lb]
}

resource "azurerm_lb_probe" "vmss_lb_probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.vmss_lb.id

  protocol            = "Http"
  port                = 80
  request_path = "/"


  depends_on = [azurerm_lb.vmss_lb]
}

resource "azurerm_lb_rule" "vmss_lb_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.vmss_lb.id

  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicFrontendIp"

  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.vmss_lb_backend.id]
  probe_id                       = azurerm_lb_probe.vmss_lb_probe.id

  depends_on = [
    azurerm_lb_backend_address_pool.vmss_lb_backend,
    azurerm_lb_probe.vmss_lb_probe
  ]
}

resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                = "vmss1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.size_vm
  instances           = 2
  zones               = ["1", "2", "3"]
  admin_username      = var.admin_name
  admin_password      = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true
    network_security_group_id = azurerm_network_security_group.vm1_nsg.id

    ip_configuration {
      name      = "internal"
      subnet_id = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.vmss_lb_backend.id]
    }
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_subnet.subnet
  ]
}

resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = "vmss1-autoscale"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_windows_virtual_machine_scale_set.vmss.id

  profile {
    name = "autoscale-cpu"

    capacity {
      default = 2
      maximum = 10
      minimum = 2
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_windows_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "PercentChangeCount"
        value     = 50
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_windows_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "PercentChangeCount"
        value     = 50
        cooldown  = "PT5M"
      }
    }
  }
}