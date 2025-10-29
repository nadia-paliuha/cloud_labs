variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID (Service Principal)"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
  sensitive   = true
}

variable "client_ip" {
  description = "Ip of user"
}

variable "group_name" {
  type = string
  description = "Name of group"
  default = "az104-rg8"
}

variable "location" {
  type = string
  description = "Location of resources"
  default = "polandcentral"
}

variable "admin_name" {
  type = string
  description = "Name of admin"
  default = "localadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
  description = "Admin password for the VM"
}

variable "size_vm" {
  type = string
  default = "Standard_B1ms"
}