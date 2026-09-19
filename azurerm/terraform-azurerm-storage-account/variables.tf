variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Storage Account."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Storage Account should exist. Changing this forces a new Storage Account to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Storage Account. Changing this forces a new Storage Account to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "account_tier" {
  type        = string
  description = "(Optional) Defines the Tier to use for this Storage Account. Valid options are Standard and Premium. Defaults to Standard."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "(Optional) Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Defaults to LRS."
  default     = "LRS"
}

variable "account_kind" {
  type        = string
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
  default     = "StorageV2"
}

variable "access_tier" {
  type        = string
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool. Defaults to Hot."
  default     = "Hot"
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true."
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "(Optional) The minimum supported TLS version for the Storage Account. The only supported value is TLS1_2. Defaults to TLS1_2."
  default     = "TLS1_2"

  validation {
    # azurerm 5.x no longer accepts TLS1_0 or TLS1_1.
    condition     = contains(["TLS1_2"], var.min_tls_version)
    error_message = "min_tls_version must be TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to false."
  default     = false
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "(Optional) Indicates whether the Storage Account permits requests to be authorized with the account access key via Shared Key. Defaults to true."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether the public network access is enabled. Defaults to true."
  default     = true
}

variable "default_to_oauth_authentication" {
  type        = bool
  description = "(Optional) Default to Microsoft Entra authorization in the Azure portal when accessing the Storage Account. Defaults to false."
  default     = false
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to false."
  default     = false
}

variable "is_hns_enabled" {
  type        = bool
  description = "(Optional) Is Hierarchical Namespace enabled? Changing this forces a new resource to be created. Defaults to false."
  default     = false
}

variable "local_user_enabled" {
  type        = bool
  description = "(Optional) Is Local User Enabled? Defaults to true."
  default     = true
}

variable "sftp_enabled" {
  type        = bool
  description = "(Optional) Boolean, enable SFTP for the Storage Account. Defaults to false."
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

variable "blob_properties" {
  type = object({
    versioning_enabled                 = optional(bool, false)
    change_feed_enabled                = optional(bool, false)
    last_access_time_enabled           = optional(bool, false)
    delete_retention_in_days           = optional(number)
    container_delete_retention_in_days = optional(number)
    cors_rules = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), [])
  })
  description = "(Optional) A blob_properties block, used to configure soft delete, versioning and CORS for the Blob service."
  default     = null
}

variable "network_rules" {
  type = object({
    default_action             = optional(string, "Deny")
    bypass                     = optional(list(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  description = <<DESCRIPTION
  (Optional) A network_rules block:
    default_action             - (Required) Specifies the default action of allow or deny when no other rules match. Defaults to Deny.
    bypass                     - (Optional) Which traffic can bypass the network rules. Possible values are any combination of Logging, Metrics, AzureServices and None.
    ip_rules                   - (Optional) List of public IP or IP ranges in CIDR format which are allowed to access the Storage Account.
    virtual_network_subnet_ids - (Optional) A list of virtual network subnet IDs which are allowed to access the Storage Account.
  DESCRIPTION
  default     = null
}

variable "containers" {
  type = map(object({
    container_access_type = optional(string, "private")
    metadata              = optional(map(string))
  }))
  description = <<DESCRIPTION
  (Optional) A map of Blob containers to create, keyed by container name:
    container_access_type - (Optional) The Access Level configured for this Container. Possible values are blob, container and private. Defaults to private.
    metadata              - (Optional) A mapping of MetaData for this Container.
  DESCRIPTION
  default     = {}
}

variable "queues" {
  type = map(object({
    metadata = optional(map(string))
  }))
  description = "(Optional) A map of Storage Queues to create, keyed by queue name."
  default     = {}
}

variable "lifecycle_rules" {
  type = map(object({
    enabled                                    = optional(bool, true)
    prefix_match                               = optional(set(string))
    blob_types                                 = optional(list(string), ["blockBlob"])
    delete_after_days_since_creation           = optional(number)
    delete_after_days_since_modification       = optional(number)
    tier_to_cool_after_days_since_modification = optional(number)
  }))
  description = <<DESCRIPTION
  (Optional) A map of Blob lifecycle management rules, keyed by rule name. Used to expire temporary artefacts such as
  upload chunks and converted output files.
  DESCRIPTION
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
  (Optional) A mapping of tags which should be assigned to the Storage Account

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
