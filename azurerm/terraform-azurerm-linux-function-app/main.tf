resource "azurerm_linux_function_app" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_account_access_key
  storage_uses_managed_identity = var.storage_uses_managed_identity

  app_settings                = var.app_settings
  https_only                  = var.https_only
  functions_extension_version = var.functions_extension_version
  builtin_logging_enabled     = var.builtin_logging_enabled
  client_certificate_enabled  = var.client_certificate_enabled
  enabled                     = var.enabled

  public_network_access_enabled   = var.public_network_access_enabled
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  site_config {
    always_on                              = var.site_config.always_on
    application_insights_connection_string = var.site_config.application_insights_connection_string
    application_insights_key               = var.site_config.application_insights_key
    app_scale_limit                        = var.site_config.app_scale_limit
    elastic_instance_minimum               = var.site_config.elastic_instance_minimum
    pre_warmed_instance_count              = var.site_config.pre_warmed_instance_count
    health_check_path                      = var.site_config.health_check_path
    http2_enabled                          = var.site_config.http2_enabled
    minimum_tls_version                    = var.site_config.minimum_tls_version
    ftps_state                             = var.site_config.ftps_state
    vnet_route_all_enabled                 = var.site_config.vnet_route_all_enabled
    runtime_scale_monitoring_enabled       = var.site_config.runtime_scale_monitoring_enabled
    use_32_bit_worker                      = var.site_config.use_32_bit_worker
    worker_count                           = var.site_config.worker_count
    ip_restriction_default_action          = var.site_config.ip_restriction_default_action

    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []

      content {
        python_version = application_stack.value.python_version
        node_version   = application_stack.value.node_version
        java_version   = application_stack.value.java_version
        dotnet_version = application_stack.value.dotnet_version
      }
    }

    dynamic "cors" {
      for_each = var.site_config.cors != null ? [var.site_config.cors] : []

      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }

    dynamic "ip_restriction" {
      for_each = var.site_config.ip_restrictions
      iterator = ip_restriction

      content {
        name                      = ip_restriction.value.name
        action                    = ip_restriction.value.action
        priority                  = ip_restriction.value.priority
        ip_address                = ip_restriction.value.ip_address
        service_tag               = ip_restriction.value.service_tag
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
      }
    }
  }

  tags = var.tags != null ? var.tags : module.tags[0].tags

  lifecycle {
    # The deployment pipeline (func azure functionapp publish) owns the
    # application package, so the settings it rewrites are not managed here.
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["WEBSITE_CONTENTSHARE"],
      app_settings["WEBSITE_CONTENTAZUREFILECONNECTIONSTRING"],
      tags["hidden-link: /app-insights-resource-id"],
    ]
  }
}
