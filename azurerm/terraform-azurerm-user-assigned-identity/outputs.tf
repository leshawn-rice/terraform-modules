output "name" {
  value       = azurerm_user_assigned_identity.this.name
  description = "The Name of the User Assigned Identity."
}

output "id" {
  value       = azurerm_user_assigned_identity.this.id
  description = "The ID of the User Assigned Identity."
}

output "principal_id" {
  value       = azurerm_user_assigned_identity.this.principal_id
  description = "The Service Principal ID of the User Assigned Identity, used for role assignments."
}

output "client_id" {
  value       = azurerm_user_assigned_identity.this.client_id
  description = "The Client ID of the User Assigned Identity."
}

output "tenant_id" {
  value       = azurerm_user_assigned_identity.this.tenant_id
  description = "The Tenant ID of the User Assigned Identity."
}
