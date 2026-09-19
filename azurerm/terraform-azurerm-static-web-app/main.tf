resource "azurerm_static_web_app" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_tier = var.sku_tier
  sku_size = var.sku_size

  app_settings                       = var.app_settings
  preview_environments_enabled       = var.preview_environments_enabled
  configuration_file_changes_enabled = var.configuration_file_changes_enabled
  public_network_access_enabled      = var.public_network_access_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "basic_auth" {
    for_each = var.basic_auth != null ? [var.basic_auth] : []

    content {
      password     = basic_auth.value.password
      environments = basic_auth.value.environments
    }
  }

  tags = var.tags != null ? var.tags : module.tags[0].tags
}

resource "azurerm_static_web_app_custom_domain" "this" {
  for_each = var.custom_domains

  static_web_app_id = azurerm_static_web_app.this.id
  domain_name       = each.key
  validation_type   = each.value.validation_type
}
