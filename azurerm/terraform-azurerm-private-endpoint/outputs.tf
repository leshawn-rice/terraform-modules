output "name" {
  value       = azurerm_private_endpoint.this.name
  description = "The Name of the Private Endpoint."
}

output "id" {
  value       = azurerm_private_endpoint.this.id
  description = "The ID of the Private Endpoint."
}

output "network_interface_id" {
  value       = one(azurerm_private_endpoint.this.network_interface[*].id)
  description = "The ID of the Network Interface associated with the Private Endpoint."
}

output "private_ip_address" {
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
  description = "The private IP address associated with the Private Endpoint."
}
