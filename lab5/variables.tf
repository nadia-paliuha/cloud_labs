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

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
  default     = "centralus"
}

variable "resource_group_name" {
  type    = string
  default = "az104-rg5"
}

variable "size_vm" {
  type = string
  default = "Standard_B2ms"
}

variable "admin_username" {
  type    = string
  default = "localadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
  description = "Admin password for the VM"
}