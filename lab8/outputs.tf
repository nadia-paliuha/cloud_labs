output "vm1_public_ip" {
  value = azurerm_public_ip.vm1_pip.ip_address
  description = "Public Ip VM1"
}

output "vm2_public_ip" {
  value = azurerm_public_ip.vm2_pip.ip_address
  description = "Public Ip VM1"
}

output "vmss_lb_public_ip" {
  value = azurerm_public_ip.vmss_lb_pip.ip_address
  description = "Public Ip VM1 Load Balancer"
}

output "vm1_private_ip" {
  value = azurerm_network_interface.nic_vm1.private_ip_address
  description = "Private Ip VM1"
}

output "vm2_private_ip" {
  value = azurerm_network_interface.nic_vm2.private_ip_address
  description = "Private Ip VM2"
}

output "vmss_name" {
  value = azurerm_windows_virtual_machine_scale_set.vmss.name
  description = "Name of VM Scale Set"
}

output "network_security_group_id" {
  value = azurerm_network_security_group.vm1_nsg.id
  description = "ID Network Security Group for VMSS"
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
  description = "Name of Virtual Network"
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
  description = "ID Subnet"
}
