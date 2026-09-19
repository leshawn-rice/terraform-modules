resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                            = var.sku
  retention_in_days              = var.retention_in_days
  daily_quota_gb                 = var.daily_quota_gb
  internet_ingestion_access_type = var.internet_ingestion_access_type
  internet_query_access_type     = var.internet_query_access_type

  tags = var.tags != null ? var.tags : module.tags[0].tags
}
