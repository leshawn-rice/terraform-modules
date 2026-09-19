variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Log Analytics Workspace."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Log Analytics Workspace should exist."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Log Analytics Workspace.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation and PerGB2018. Defaults to PerGB2018."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  default     = 30
}

variable "daily_quota_gb" {
  type        = number
  description = "(Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited)."
  default     = -1
}

variable "internet_ingestion_access_type" {
  type        = string
  description = "(Optional) Controls public network access for ingestion into the Log Analytics Workspace. Possible values are Enabled, Disabled and SecuredByPerimeter. Defaults to Enabled."
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled", "SecuredByPerimeter"], var.internet_ingestion_access_type)
    error_message = "internet_ingestion_access_type must be one of Enabled, Disabled or SecuredByPerimeter."
  }
}

variable "internet_query_access_type" {
  type        = string
  description = "(Optional) Controls public network access for querying the Log Analytics Workspace. Possible values are Enabled, Disabled and SecuredByPerimeter. Defaults to Enabled."
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled", "SecuredByPerimeter"], var.internet_query_access_type)
    error_message = "internet_query_access_type must be one of Enabled, Disabled or SecuredByPerimeter."
  }
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
  (Optional) A mapping of tags which should be assigned to the Log Analytics Workspace

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
