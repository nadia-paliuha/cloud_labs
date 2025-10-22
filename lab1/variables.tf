variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "client_id" {
  description = "Azure Application (Client) ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Application (Client) Secret"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "Microsoft Entra domain name (example: mytenant.onmicrosoft.com)"
  type        = string
}

variable "external_user_email" {
  description = "Email of invited external user"
  type        = string
  default     = ""
}

variable "external_user_name" {
  description = "Email of invited external user"
  type        = string
  default     = ""
}