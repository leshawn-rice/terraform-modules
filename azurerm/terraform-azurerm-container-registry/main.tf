resource "azurerm_container_registry" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  retention_policy_in_days      = var.retention_policy_in_days

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }


  tags = var.tags != null ? var.tags : module.tags[0].tags
}
