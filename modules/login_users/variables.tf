variable "role_assignment_scope" {
  type    = string
  default = "/"
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "console_login_users" {
  type = map(object({
    user_principal_name     = string
    principal_object_id     = optional(string)
    invite_external_user    = optional(bool)
    invitation_redirect_url = optional(string, "https://portal.azure.com")
    role_definition_name    = optional(string, "Reader")
  }))
  default = {}
}
