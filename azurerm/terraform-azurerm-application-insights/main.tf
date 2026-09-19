resource "azurerm_application_insights" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  application_type                     = var.application_type
  workspace_id                         = var.workspace_id
  retention_in_days                    = var.retention_in_days
  sampling_percentage                  = var.sampling_percentage
  daily_data_cap_in_gb                 = var.daily_data_cap_in_gb
  daily_data_cap_notifications_enabled = var.daily_data_cap_notifications_enabled
  ip_masking_enabled                   = var.ip_masking_enabled
  local_authentication_enabled         = var.local_authentication_enabled
  internet_ingestion_enabled           = var.internet_ingestion_enabled
  internet_query_enabled               = var.internet_query_enabled

  tags = var.tags != null ? var.tags : module.tags[0].tags
}
