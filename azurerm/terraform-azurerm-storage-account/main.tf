resource "azurerm_storage_account" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier

  https_traffic_only_enabled       = var.https_traffic_only_enabled
  min_tls_version                  = var.min_tls_version
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  is_hns_enabled                   = var.is_hns_enabled
  local_user_enabled               = var.local_user_enabled
  sftp_enabled                     = var.sftp_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []

    content {
      versioning_enabled       = blob_properties.value.versioning_enabled
      change_feed_enabled      = blob_properties.value.change_feed_enabled
      last_access_time_enabled = blob_properties.value.last_access_time_enabled

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_in_days != null ? [blob_properties.value.delete_retention_in_days] : []

        content {
          days = delete_retention_policy.value
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_in_days != null ? [blob_properties.value.container_delete_retention_in_days] : []

        content {
          days = container_delete_retention_policy.value
        }
      }

      dynamic "cors_rule" {
        for_each = blob_properties.value.cors_rules
        iterator = cors_rule

        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []

    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }

  tags = var.tags != null ? var.tags : module.tags[0].tags
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.key
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = each.value.container_access_type
  metadata              = each.value.metadata
}

resource "azurerm_storage_queue" "this" {
  for_each = var.queues

  name               = each.key
  storage_account_id = azurerm_storage_account.this.id
  metadata           = each.value.metadata
}

resource "azurerm_storage_management_policy" "this" {
  count = length(var.lifecycle_rules) > 0 ? 1 : 0

  storage_account_id = azurerm_storage_account.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    iterator = rule

    content {
      name    = rule.key
      enabled = rule.value.enabled

      filters {
        prefix_match = rule.value.prefix_match
        blob_types   = rule.value.blob_types
      }

      actions {
        base_blob {
          delete_after_days_since_creation_greater_than           = rule.value.delete_after_days_since_creation
          delete_after_days_since_modification_greater_than       = rule.value.delete_after_days_since_modification
          tier_to_cool_after_days_since_modification_greater_than = rule.value.tier_to_cool_after_days_since_modification
        }
      }
    }
  }
}
