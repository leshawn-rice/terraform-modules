output "name" {
  value       = azurerm_private_dns_zone.this.name
  description = "The Name of the Private DNS Zone."
}

output "id" {
  value       = azurerm_private_dns_zone.this.id
  description = "The ID of the Private DNS Zone."
}

output "virtual_network_link_ids" {
  value       = { for name, link in azurerm_private_dns_zone_virtual_network_link.this : name => link.id }
  description = "A map of link name to the ID of the Private DNS Zone Virtual Network Link."
}
