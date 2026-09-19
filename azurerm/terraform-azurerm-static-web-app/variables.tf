variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Static Web App."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Static Web App should exist. Changing this forces a new Static Web App to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Static Web App. Changing this forces a new Static Web App to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "sku_tier" {
  type        = string
  description = "(Optional) Specifies the SKU tier of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  default     = "Free"
}

variable "sku_size" {
  type        = string
  description = "(Optional) Specifies the SKU size of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  default     = "Free"
}

variable "app_settings" {
  type        = map(string)
  description = "(Optional) A key-value pair of App Settings for the Static Web App's managed API."
  default     = {}
}

variable "preview_environments_enabled" {
  type        = bool
  description = "(Optional) Are preview (staging) environments enabled? Defaults to true."
  default     = true
}

variable "configuration_file_changes_enabled" {
  type        = bool
  description = "(Optional) Should changes to the configuration file be permitted? Defaults to true."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Should public network access be enabled for the Static Web App? Defaults to true."
  default     = true
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = <<DESCRIPTION
  (Optional) An identity block:
    type         - (Required) SystemAssigned or UserAssigned.
    identity_ids - (Optional) A list of User Assigned Identity IDs. Required when type is UserAssigned.
  DESCRIPTION
  default     = null

  validation {
    # azurerm 5.x no longer accepts the combined "SystemAssigned, UserAssigned" value.
    condition     = var.identity == null ? true : contains(["SystemAssigned", "UserAssigned"], var.identity.type)
    error_message = "identity.type must be either SystemAssigned or UserAssigned."
  }
}

variable "basic_auth" {
  type = object({
    password     = string
    environments = string
  })
  description = <<DESCRIPTION
  (Optional) A basic_auth block:
    password     - (Required) The password for the basic authentication access.
    environments - (Required) The environments to protect. Possible values are AllEnvironments, StagingEnvironments and Both.
  DESCRIPTION
  default     = null
  sensitive   = true
}

variable "custom_domains" {
  type = map(object({
    validation_type = optional(string, "cname-delegation")
  }))
  description = <<DESCRIPTION
  (Optional) A map of custom domains to attach to the Static Web App, keyed by domain name:
    validation_type - (Optional) One of cname-delegation or dns-txt-token. Defaults to cname-delegation.

  The DNS records must exist before the apply completes, otherwise validation times out.
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
  (Optional) A mapping of tags which should be assigned to the Static Web App

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
