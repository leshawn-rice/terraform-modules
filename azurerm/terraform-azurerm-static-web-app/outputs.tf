output "name" {
  value       = azurerm_static_web_app.this.name
  description = "The Name of the Static Web App."
}

output "id" {
  value       = azurerm_static_web_app.this.id
  description = "The ID of the Static Web App."
}

output "default_host_name" {
  value       = azurerm_static_web_app.this.default_host_name
  description = "The default host name of the Static Web App."
}

output "api_key" {
  value       = azurerm_static_web_app.this.api_key
  description = "The deployment token of the Static Web App, used by the GitHub Actions workflow."
  sensitive   = true
}

output "identity_principal_id" {
  value       = try(azurerm_static_web_app.this.identity[0].principal_id, null)
  description = "The Principal ID of the Static Web App's managed identity, if one is configured."
}
