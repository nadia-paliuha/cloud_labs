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

variable "helpdesk_group_name" {
  description = "Name of Help Desk Azure AD group"
  type        = string
  default     = "helpdesk"
}
