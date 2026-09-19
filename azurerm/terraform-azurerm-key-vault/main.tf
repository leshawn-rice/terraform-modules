resource "azurerm_key_vault" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id != null ? var.tenant_id : data.azurerm_client_config.current[0].tenant_id

  sku_name                        = var.sku_name
  rbac_authorization_enabled      = var.rbac_authorization_enabled
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  public_network_access_enabled   = var.public_network_access_enabled

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }

  tags = var.tags != null ? var.tags : module.tags[0].tags
}

resource "azurerm_key_vault_secret" "this" {
  # Secret names are not sensitive; the values they map to are, and a sensitive
  # value cannot be used as a for_each key.
  for_each = nonsensitive(toset(keys(var.secrets)))

  name         = each.key
  value        = var.secrets[each.key].value
  key_vault_id = azurerm_key_vault.this.id

  content_type    = var.secrets[each.key].content_type
  expiration_date = var.secrets[each.key].expiration_date
  not_before_date = var.secrets[each.key].not_before_date

  tags = var.tags != null ? var.tags : module.tags[0].tags

  lifecycle {
    # Secret values are rotated outside of Terraform; only the secret's
    # existence is managed here.
    ignore_changes = [value]
  }
}
