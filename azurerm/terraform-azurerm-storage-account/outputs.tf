output "name" {
  value       = azurerm_storage_account.this.name
  description = "The Name of the Storage Account."
}

output "id" {
  value       = azurerm_storage_account.this.id
  description = "The ID of the Storage Account."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.this.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_queue_endpoint" {
  value       = azurerm_storage_account.this.primary_queue_endpoint
  description = "The endpoint URL for queue storage in the primary location."
}

output "primary_access_key" {
  value       = azurerm_storage_account.this.primary_access_key
  description = "The primary access key for the Storage Account."
  sensitive   = true
}

output "primary_connection_string" {
  value       = azurerm_storage_account.this.primary_connection_string
  description = "The connection string associated with the primary location."
  sensitive   = true
}

output "identity_principal_id" {
  value       = try(azurerm_storage_account.this.identity[0].principal_id, null)
  description = "The Principal ID of the Storage Account's managed identity, if one is configured."
}

output "container_names" {
  value       = [for container in azurerm_storage_container.this : container.name]
  description = "The names of the Blob containers created in this Storage Account."
}

output "queue_names" {
  value       = [for queue in azurerm_storage_queue.this : queue.name]
  description = "The names of the Storage Queues created in this Storage Account."
}
