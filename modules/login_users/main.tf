data "azuread_domains" "tenant" {
  only_root = true
}

locals {
  verified_domains = toset([
    for d in data.azuread_domains.tenant.domains : lower(d.domain_name)
    if d.verified
  ])

  user_domains = {
    for k, v in var.console_login_users :
    k => (
      length(split("@", v.user_principal_name)) > 1
      ? lower(element(split("@", v.user_principal_name), 1))
      : ""
    )
  }

  should_invite = {
    for k, v in var.console_login_users :
    k => coalesce(
      try(v.invite_external_user, null),
      !contains(local.verified_domains, local.user_domains[k])
    )
  }

  existing_user_lookups = {
    for k, v in var.console_login_users :
    k => v
    if try(v.principal_object_id, null) == null && !local.should_invite[k]
  }

  invited_user_lookups = {
    for k, v in var.console_login_users :
    k => v
    if try(v.principal_object_id, null) == null && local.should_invite[k]
  }
}

data "azuread_user" "console_login" {
  for_each = local.existing_user_lookups

  user_principal_name = each.value.user_principal_name
}

resource "azuread_invitation" "console_login" {
  for_each = local.invited_user_lookups

  user_email_address = each.value.user_principal_name
  redirect_url       = each.value.invitation_redirect_url
}

resource "azurerm_role_assignment" "console_login" {
  for_each = var.console_login_users

  scope                = var.role_assignment_scope
  role_definition_name = each.value.role_definition_name
  principal_id = coalesce(
    try(each.value.principal_object_id, null),
    try(data.azuread_user.console_login[each.key].object_id, null),
    try(azuread_invitation.console_login[each.key].user_id, null)
  )
}
