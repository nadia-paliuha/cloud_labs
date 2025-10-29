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

variable "image" {
  type = string
  description = "Image for container"
}

variable "group_name" {
  type = string
  description = "Name of group"
  default = "az104-rg9c"
}

variable "location" {
  type = string
  description = "Location of resources"
  default = "polandcentral"
}

