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

variable "group_name" {
  type = string
  description = "Name of group"
  default = "az104-lab11"
}

variable "location" {
  type = string
  description = "Location of resources"
  default = "West Europe"
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

variable "storage_name" {
  type = string
  description = "Name of storage"
  default = "st0rage1l0ab11"
}

variable "email" {
  type = string
  description = "Email of user"
  default = "nadyapaliuha@gmail.com"
}
