terraform {
  source = "${get_repo_root()}/modules/login_users"
}

include {
  path = find_in_parent_folders()
}

locals {
  tenant_role_scope = "/"
}

inputs = {
  role_assignment_scope = local.tenant_role_scope

  console_login_users = {
    chechia = {
      user_principal_name  = "chechiachang999@gmail.com"
      invite_external_user = true
      role_definition_name = "Reader"
    }
    johnlin = {
      user_principal_name  = "linton.tw@gmail.com"
      invite_external_user = true
      role_definition_name = "Reader"
    }
  }
}
