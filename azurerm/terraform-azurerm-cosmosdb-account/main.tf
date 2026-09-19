resource "azurerm_cosmosdb_account" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  offer_type = var.offer_type
  kind       = var.kind

  automatic_failover_enabled        = var.automatic_failover_enabled
  multiple_write_locations_enabled  = var.multiple_write_locations_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  ip_range_filter                   = var.ip_range_filter
  local_authentication_enabled      = var.local_authentication_enabled
  free_tier_enabled                 = var.free_tier_enabled
  minimal_tls_version               = var.minimal_tls_version

  consistency_policy {
    consistency_level       = var.consistency_policy.consistency_level
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
  }

  dynamic "geo_location" {
    for_each = var.geo_locations
    iterator = geo_location

    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities
    iterator = capability

    content {
      name = capability.value
    }
  }

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_subnet_ids
    iterator = subnet

    content {
      id = subnet.value
    }
  }

  dynamic "backup" {
    for_each = var.backup != null ? [var.backup] : []

    content {
      type                = backup.value.type
      interval_in_minutes = backup.value.interval_in_minutes
      retention_in_hours  = backup.value.retention_in_hours
      storage_redundancy  = backup.value.storage_redundancy
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = var.tags != null ? var.tags : module.tags[0].tags
}

resource "azurerm_cosmosdb_sql_database" "this" {
  for_each = var.databases

  name                = each.key
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = each.value.throughput

  dynamic "autoscale_settings" {
    for_each = each.value.max_throughput != null ? [each.value.max_throughput] : []

    content {
      max_throughput = autoscale_settings.value
    }
  }
}

resource "azurerm_cosmosdb_sql_container" "this" {
  for_each = local.containers

  name                  = each.value.container_name
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this[each.value.database_name].name
  partition_key_paths   = each.value.partition_key_paths
  partition_key_version = each.value.partition_key_version
  throughput            = each.value.throughput
  default_ttl           = each.value.default_ttl

  dynamic "autoscale_settings" {
    for_each = each.value.max_throughput != null ? [each.value.max_throughput] : []

    content {
      max_throughput = autoscale_settings.value
    }
  }

  dynamic "unique_key" {
    for_each = each.value.unique_key_paths
    iterator = unique_key

    content {
      paths = unique_key.value
    }
  }
}
