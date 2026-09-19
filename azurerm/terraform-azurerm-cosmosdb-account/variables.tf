variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the CosmosDB Account."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the CosmosDB Account should exist. Changing this forces a new CosmosDB Account to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this CosmosDB Account. Changing this forces a new CosmosDB Account to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "offer_type" {
  type        = string
  description = "(Optional) Specifies the Offer Type to use for this CosmosDB Account. Currently, this can only be set to Standard."
  default     = "Standard"
}

variable "kind" {
  type        = string
  description = "(Optional) Specifies the Kind of CosmosDB to create. Possible values are GlobalDocumentDB, MongoDB and Parse. Defaults to GlobalDocumentDB."
  default     = "GlobalDocumentDB"
}

variable "consistency_policy" {
  type = object({
    consistency_level       = optional(string, "Session")
    max_interval_in_seconds = optional(number)
    max_staleness_prefix    = optional(number)
  })
  description = <<DESCRIPTION
  (Optional) A consistency_policy block:
    consistency_level       - (Required) The Consistency Level to use. Possible values are BoundedStaleness, Eventual, Session, Strong and ConsistentPrefix. Defaults to Session.
    max_interval_in_seconds - (Optional) Only applicable when consistency_level is BoundedStaleness.
    max_staleness_prefix    - (Optional) Only applicable when consistency_level is BoundedStaleness.
  DESCRIPTION
  default     = {}
}

variable "geo_locations" {
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = optional(bool, false)
  }))
  description = "(Required) One or more geo_location blocks describing the geographic locations the data is replicated to."
}

variable "capabilities" {
  type        = list(string)
  description = "(Optional) A list of CosmosDB capabilities to enable, for example EnableServerless or EnableTable."
  default     = []
}

variable "automatic_failover_enabled" {
  type        = bool
  description = "(Optional) Enable automatic failover for this CosmosDB Account. Defaults to false."
  default     = false
}

variable "multiple_write_locations_enabled" {
  type        = bool
  description = "(Optional) Enable multiple write locations for this CosmosDB Account. Defaults to false."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether or not public network access is allowed for this CosmosDB Account. Defaults to true."
  default     = true
}

variable "is_virtual_network_filter_enabled" {
  type        = bool
  description = "(Optional) Enables virtual network filtering for this CosmosDB Account. Defaults to false."
  default     = false
}

variable "virtual_network_subnet_ids" {
  type        = list(string)
  description = "(Optional) A list of Subnet IDs which should be able to access this CosmosDB Account. Requires is_virtual_network_filter_enabled to be true."
  default     = []
}

variable "ip_range_filter" {
  type        = set(string)
  description = "(Optional) A set of IP addresses or CIDR blocks to be allowed through the firewall."
  default     = null
}

variable "local_authentication_enabled" {
  type        = bool
  description = "(Optional) Whether local authentication (account keys) is enabled. Set to false to ensure only Entra ID can be used. Defaults to true."
  default     = true
}

variable "free_tier_enabled" {
  type        = bool
  description = "(Optional) Enable the Free Tier pricing option. Only one free tier account is permitted per subscription. Changing this forces a new resource to be created. Defaults to false."
  default     = false
}

variable "minimal_tls_version" {
  type        = string
  description = "(Optional) Specifies the minimal TLS version for the CosmosDB Account. The only supported value is Tls12. Defaults to Tls12."
  default     = "Tls12"

  validation {
    # azurerm 5.x no longer accepts Tls or Tls11.
    condition     = contains(["Tls12"], var.minimal_tls_version)
    error_message = "minimal_tls_version must be Tls12."
  }
}

variable "backup" {
  type = object({
    type                = string
    interval_in_minutes = optional(number)
    retention_in_hours  = optional(number)
    storage_redundancy  = optional(string)
  })
  description = <<DESCRIPTION
  (Optional) A backup block:
    type                - (Required) The type of the backup. Possible values are Continuous and Periodic.
    interval_in_minutes - (Optional) The interval in minutes between two backups, only applicable to Periodic backups.
    retention_in_hours  - (Optional) The time in hours that each backup is retained, only applicable to Periodic backups.
    storage_redundancy  - (Optional) The storage redundancy used to store backups, only applicable to Periodic backups.
  DESCRIPTION
  default     = null
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

variable "databases" {
  type = map(object({
    throughput     = optional(number)
    max_throughput = optional(number)
    containers = optional(map(object({
      partition_key_paths   = list(string)
      partition_key_version = optional(number)
      throughput            = optional(number)
      max_throughput        = optional(number)
      default_ttl           = optional(number)
      unique_key_paths      = optional(list(list(string)), [])
    })), {})
  }))
  description = <<DESCRIPTION
  (Optional) A map of SQL databases to create, keyed by database name. Each database may declare a map of containers,
  keyed by container name:
    partition_key_paths - (Required) A list of partition key paths, for example ["/id"].
    throughput          - (Optional) Manually provisioned RU/s. Cannot be set on serverless accounts.
    max_throughput      - (Optional) Maximum RU/s for autoscale. Cannot be set on serverless accounts.
    default_ttl         - (Optional) The default time to live for items in the container, in seconds.
    unique_key_paths    - (Optional) A list of unique key path lists.
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
  (Optional) A mapping of tags which should be assigned to the CosmosDB Account

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
