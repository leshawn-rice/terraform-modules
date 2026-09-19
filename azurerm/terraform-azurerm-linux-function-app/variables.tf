variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Function App."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Function App should exist. Changing this forces a new Function App to be created."
}

variable "service_plan_id" {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Function App."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Function App. Changing this forces a new Function App to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "storage_account_name" {
  type        = string
  description = "(Optional) The backend storage account name which will be used by this Function App."
  default     = null
}

variable "storage_account_access_key" {
  type        = string
  description = "(Optional) The access key which will be used to access the backend storage account for the Function App. Conflicts with storage_uses_managed_identity."
  default     = null
  sensitive   = true
}

variable "storage_uses_managed_identity" {
  type        = bool
  description = "(Optional) Should the Function App use Managed Identity to access the storage account. Conflicts with storage_account_access_key."
  default     = null
}

variable "app_settings" {
  type        = map(string)
  description = "(Optional) A map of key-value pairs for App Settings and custom values."
  default     = {}
}

variable "https_only" {
  type        = bool
  description = "(Optional) Can the Function App only be accessed via HTTPS? Defaults to true."
  default     = true
}

variable "functions_extension_version" {
  type        = string
  description = "(Optional) The runtime version associated with the Function App. Defaults to ~4."
  default     = "~4"
}

variable "builtin_logging_enabled" {
  type        = bool
  description = "(Optional) Should built-in logging be enabled? Defaults to true."
  default     = true
}

variable "client_certificate_enabled" {
  type        = bool
  description = "(Optional) Should the Function App use Client Certificates? Defaults to false."
  default     = false
}

variable "enabled" {
  type        = bool
  description = "(Optional) Is the Function App enabled? Defaults to true."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Should public network access be enabled for the Function App? Defaults to true."
  default     = true
}

variable "virtual_network_subnet_id" {
  type        = string
  description = "(Optional) The subnet ID which will be used by this Function App for regional virtual network integration."
  default     = null
}

variable "key_vault_reference_identity_id" {
  type        = string
  description = "(Optional) The User Assigned Identity ID used for accessing Key Vault secrets referenced in App Settings."
  default     = null
}

variable "ftp_publish_basic_authentication_enabled" {
  type        = bool
  description = "(Optional) Should the default FTP Basic Authentication publishing profile be enabled. Defaults to false."
  default     = false
}

variable "webdeploy_publish_basic_authentication_enabled" {
  type        = bool
  description = "(Optional) Should the default WebDeploy Basic Authentication publishing credentials be enabled. Defaults to false."
  default     = false
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = <<DESCRIPTION
  (Optional) An identity block:
    type         - (Required) SystemAssigned, UserAssigned or 'SystemAssigned, UserAssigned'.
    identity_ids - (Optional) A list of User Assigned Identity IDs. Required when type includes UserAssigned.
  DESCRIPTION
  default     = null
}

variable "site_config" {
  type = object({
    always_on                              = optional(bool)
    application_insights_connection_string = optional(string)
    application_insights_key               = optional(string)
    app_scale_limit                        = optional(number)
    elastic_instance_minimum               = optional(number)
    pre_warmed_instance_count              = optional(number)
    health_check_path                      = optional(string)
    http2_enabled                          = optional(bool, true)
    minimum_tls_version                    = optional(string, "1.2")
    ftps_state                             = optional(string, "Disabled")
    vnet_route_all_enabled                 = optional(bool)
    runtime_scale_monitoring_enabled       = optional(bool)
    use_32_bit_worker                      = optional(bool, false)
    worker_count                           = optional(number)
    ip_restriction_default_action          = optional(string)

    application_stack = optional(object({
      python_version = optional(string)
      node_version   = optional(string)
      java_version   = optional(string)
      dotnet_version = optional(string)
    }))

    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool, false)
    }))

    ip_restrictions = optional(list(object({
      name                      = string
      action                    = optional(string, "Allow")
      priority                  = optional(number)
      ip_address                = optional(string)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })), [])
  })
  description = "(Required) The site_config block for the Function App, including the Python runtime version and CORS settings."
  default     = {}
}

variable "application" {
  type        = string
  description = ""
  default     = null
}
variable "environment" {
  type        = string
  description = ""
  default     = null
}
variable "business_unit" {
  type        = string
  description = ""
  default     = null
}
variable "workload" {
  type        = string
  description = ""
  default     = null
}
variable "instance_number" {
  type        = string
  description = ""
  default     = null
}
variable "service" {
  type        = string
  description = ""
  default     = null
}

variable "tags" {
  type        = map(string)
  description = <<DESCRIPTION
  (Optional) A mapping of tags which should be assigned to the Function App

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
