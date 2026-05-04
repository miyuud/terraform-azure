output "role_assignment_ids" {
  value = { for k, v in azurerm_role_assignment.console_login : k => v.id }
}
