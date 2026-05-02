output "account_id" {
  value = azurerm_cognitive_account.this.id
}

output "account_endpoint" {
  value = azurerm_cognitive_account.this.endpoint
}

output "deployment_ids" {
  value = { for k, v in azurerm_cognitive_deployment.this : k => v.id }
}

output "rai_policy_ids" {
  value = { for k, v in azurerm_cognitive_account_rai_policy.this : k => v.id }
}

output "project_ids" {
  value = { for k, v in azurerm_cognitive_account_project.this : k => v.id }
}
