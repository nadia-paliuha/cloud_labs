output "load_balancer_public_ip" {
  description = "Public IP address of the Load Balancer"
  value       = azurerm_public_ip.lb_pip.ip_address
}

output "application_gateway_public_ip" {
  description = "Public IP address of the Application Gateway"
  value       = azurerm_public_ip.appgw_pip.ip_address
}

output "vm_private_ips" {
  description = "Private IP addresses of all virtual machines"
  value = [
    azurerm_network_interface.nic_vm0.private_ip_address,
    azurerm_network_interface.nic_vm1.private_ip_address,
    azurerm_network_interface.nic_vm2.private_ip_address
  ]
}
