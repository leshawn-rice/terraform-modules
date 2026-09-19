variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Container Registry."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Container Registry should exist. Changing this forces a new Container Registry to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Container Registry. Changing this forces a new Container Registry to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU name of the Container Registry. Possible values are Basic, Standard and Premium. Defaults to Basic."
  default     = "Basic"
}

variable "admin_enabled" {
  type        = bool
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false; prefer managed identity based pulls."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for the Container Registry. Defaults to true."
  default     = true
}

variable "anonymous_pull_enabled" {
  type        = bool
  description = "(Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry. Requires the Standard or Premium SKU. Defaults to false."
  default     = false
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "(Optional) Whether zone redundancy is enabled for this Container Registry. Requires the Premium SKU. Defaults to false."
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

variable "retention_policy_in_days" {
  type        = number
  description = "(Optional) The number of days to retain untagged manifests for. Requires the Premium SKU. Defaults to null (policy disabled)."
  default     = null
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
  (Optional) A mapping of tags which should be assigned to the Container Registry

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
