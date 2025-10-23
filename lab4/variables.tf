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
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type    = string
  default = "az104-rg4"
}

variable "global_dns_name" {
  type        = string
  description = "Name of global DNS"
}

variable "private_dns_name" {
  type        = string
  description = "Name of private DNS"
}