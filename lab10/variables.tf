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

variable "group_name1" {
  type = string
  description = "Name of group"
  default = "az104-lab10_region1"
}

variable "group_name2" {
  type = string
  description = "Name of group"
  default = "az104-lab10_region2"
}

variable "location_region1" {
  type = string
  description = "Location of resources"
  default = "West Europe"
}

variable "location_region2" {
  type = string
  description = "Location of resources"
  default = "West US"
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

variable "storage_name_1" {
  type = string
  description = "Name of storage"
  default = "st0rage1l0ab10region1"
}

variable "storage_name_2" {
  type = string
  description = "Name of storage"
  default = "st0rage1l0ab10region2"
}