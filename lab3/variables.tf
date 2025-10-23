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
  type        = string
  description = "Region where resources will be deployed"
}

variable "resource_group_name" {
  type        = string
}

variable "disk_size_gb" {
  type        = number
  default     = 32
}

variable "disk_sku" {
  type        = string
  default     = "Standard_LRS"
}
