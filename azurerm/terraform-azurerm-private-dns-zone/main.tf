# Private DNS zone names are dictated by the Azure service being linked
# (for example privatelink.blob.core.windows.net), so the standard-naming
# module is deliberately not used here.
resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  tags = var.tags != null ? var.tags : module.tags[0].tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.virtual_network_links

  name                 = each.key
  private_dns_zone_id  = azurerm_private_dns_zone.this.id
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled

  tags = var.tags != null ? var.tags : module.tags[0].tags
}
