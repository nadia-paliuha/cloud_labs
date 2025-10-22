resource "azuread_group" "it_lab_administrators" {
  display_name     = "IT Lab Administrators"
  description      = "Administrators that manage the IT lab"
  security_enabled = true

  owners = [
    data.azuread_client_config.current.object_id
  ]

  members = [
    azuread_user.az104_user1.object_id
  ]
}


resource "azuread_group_member" "guest_member" {
  count = var.external_user_email != "" ? 1 : 0

  group_object_id  = azuread_group.it_lab_administrators.object_id
  member_object_id = azuread_invitation.guest_user[0].user_id

  depends_on = [azuread_invitation.guest_user]
}
