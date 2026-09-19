output "name" {
  value       = azurerm_linux_function_app.this.name
  description = "The Name of the Function App."
}

output "id" {
  value       = azurerm_linux_function_app.this.id
  description = "The ID of the Function App."
}

output "default_hostname" {
  value       = azurerm_linux_function_app.this.default_hostname
  description = "The default hostname of the Function App."
}

output "outbound_ip_addresses" {
  value       = azurerm_linux_function_app.this.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses."
}

output "identity_principal_id" {
  value       = try(azurerm_linux_function_app.this.identity[0].principal_id, null)
  description = "The Principal ID of the Function App's System Assigned Managed Identity, if enabled."
}
