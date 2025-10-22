resource "random_password" "user_password" {
  length  = 16
  special = true
}

resource "azuread_user" "az104_user1" {
  user_principal_name   = "az104-user1@${var.domain_name}"
  display_name          = "az104-user1"
  mail_nickname         = "az104-user1"
  password              = random_password.user_password.result
  account_enabled       = true
  force_password_change = false
  job_title             = "IT Lab Administrator"
  department            = "IT"
  usage_location        = "US"
}

resource "azuread_invitation" "guest_user" {
  count = var.external_user_email != "" ? 1 : 0

  user_email_address = var.external_user_email
  user_display_name = var.external_user_name
  redirect_url       = "https://portal.azure.com"

  message {
    body = "Welcome to Azure and our group project"
  }

}

