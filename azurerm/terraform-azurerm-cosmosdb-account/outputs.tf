output "name" {
  value       = azurerm_cosmosdb_account.this.name
  description = "The Name of the CosmosDB Account."
}

output "id" {
  value       = azurerm_cosmosdb_account.this.id
  description = "The ID of the CosmosDB Account."
}

output "endpoint" {
  value       = azurerm_cosmosdb_account.this.endpoint
  description = "The endpoint used to connect to the CosmosDB Account."
}

output "primary_key" {
  value       = azurerm_cosmosdb_account.this.primary_key
  description = "The primary key for the CosmosDB Account."
  sensitive   = true
}

output "primary_readonly_key" {
  value       = azurerm_cosmosdb_account.this.primary_readonly_key
  description = "The primary read-only key for the CosmosDB Account."
  sensitive   = true
}

output "identity_principal_id" {
  value       = try(azurerm_cosmosdb_account.this.identity[0].principal_id, null)
  description = "The Principal ID of the CosmosDB Account's managed identity, if one is configured."
}

output "database_names" {
  value       = [for database in azurerm_cosmosdb_sql_database.this : database.name]
  description = "The names of the SQL databases created in this account."
}

output "container_ids" {
  value       = { for key, container in azurerm_cosmosdb_sql_container.this : key => container.id }
  description = "A map of '<database>/<container>' to the ID of the created SQL container."
}
