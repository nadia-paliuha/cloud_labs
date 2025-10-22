variable "location" {
  description = "Azure region for the resource group"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "az104-rg2"
}

variable "cost_center_value" {
  description = "Value for the Cost Center tag"
  type        = string
  default     = "000"
}

variable "tenant_id" {
  description = "Tenant ID for Azure AD"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Client ID (Service Principal)"
  type        = string
}

variable "client_secret" {
  description = "Client Secret (Service Principal)"
  type        = string
  sensitive   = true
}
