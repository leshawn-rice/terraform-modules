output "name" {
  value       = azurerm_container_registry.this.name
  description = "The Name of the Container Registry."
}

output "id" {
  value       = azurerm_container_registry.this.id
  description = "The ID of the Container Registry."
}

output "login_server" {
  value       = azurerm_container_registry.this.login_server
  description = "The URL that can be used to log into the Container Registry."
}

output "admin_username" {
  value       = azurerm_container_registry.this.admin_username
  description = "The Username associated with the Container Registry Admin account, if enabled."
}

output "admin_password" {
  value       = azurerm_container_registry.this.admin_password
  description = "The Password associated with the Container Registry Admin account, if enabled."
  sensitive   = true
}
