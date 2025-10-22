output "az104_user1_password" {
  value     = random_password.user_password.result
  sensitive = true
}

output "local_user" {
  value = azuread_user.az104_user1
  sensitive = true
}

output "guest_user" {
  value = azuread_invitation.guest_user
  sensitive = true
}

output "it_lab_admins_group" {
  value = azuread_group.it_lab_administrators
  sensitive = true
}
