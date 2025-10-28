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
  default = "az104-rg7"
}

variable "location" {
  type = string
  description = "Location of resources"
  default = "eastus"
}
variable "storage_name" {
  type = string
  description = "Name of storage"
  default = "st0rage1l0ab7"
}
