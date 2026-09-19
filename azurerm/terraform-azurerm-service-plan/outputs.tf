output "name" {
  value       = azurerm_service_plan.this.name
  description = "The Name of the Service Plan."
}

output "id" {
  value       = azurerm_service_plan.this.id
  description = "The ID of the Service Plan."
}

output "kind" {
  value       = azurerm_service_plan.this.kind
  description = "A string representing the Kind of Service Plan."
}
