resource "azurerm_dns_zone" "public" {
  name                = var.global_dns_name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dns_a_record" "public_www" {
  name                = "www"
  zone_name           = azurerm_dns_zone.public.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 1
  records             = ["10.1.1.4"]
}

resource "azurerm_private_dns_zone" "private" {
  name                = var.private_dns_name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "manufacturing_link" {
  name                  = "manufacturing-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private.name
  virtual_network_id    = azurerm_virtual_network.manufactur_net.id
}

resource "azurerm_private_dns_a_record" "sensor_vm" {
  name                = "sensorvm"
  zone_name           = azurerm_private_dns_zone.private.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 1
  records             = ["10.1.1.4"]
}
