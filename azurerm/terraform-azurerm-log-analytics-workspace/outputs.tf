output "name" {
  value       = azurerm_log_analytics_workspace.this.name
  description = "The Name of the Log Analytics Workspace."
}

output "id" {
  value       = azurerm_log_analytics_workspace.this.id
  description = "The ID of the Log Analytics Workspace."
}

output "workspace_id" {
  value       = azurerm_log_analytics_workspace.this.workspace_id
  description = "The Workspace (Customer) ID of the Log Analytics Workspace."
}

output "primary_shared_key" {
  value       = azurerm_log_analytics_workspace.this.primary_shared_key
  description = "The Primary shared key of the Log Analytics Workspace."
  sensitive   = true
}
