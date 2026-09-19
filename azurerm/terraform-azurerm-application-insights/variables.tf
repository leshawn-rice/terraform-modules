variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Application Insights component."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Application Insights component should exist."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Application Insights component.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "application_type" {
  type        = string
  description = "(Optional) The type of Application Insights to create. Possible values are ios, java, MobileCenter, Node.JS, other, phone, store and web. Defaults to web."
  default     = "web"
}

variable "workspace_id" {
  type        = string
  description = "(Optional) The ID of the Log Analytics Workspace that this Application Insights component should be workspace-based on. Workspace-based components are required for new deployments."
  default     = null
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
  default     = 90
}

variable "sampling_percentage" {
  type        = number
  description = "(Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. Defaults to 100."
  default     = 100
}

variable "daily_data_cap_in_gb" {
  type        = number
  description = "(Optional) Specifies the Application Insights component daily data volume cap in GB."
  default     = null
}

variable "daily_data_cap_notifications_enabled" {
  type        = bool
  description = "(Optional) Whether a notification email will be sent when the daily data volume cap is met. Defaults to true."
  default     = null
}

variable "ip_masking_enabled" {
  type        = bool
  description = "(Optional) By default the real client IP is masked as 0.0.0.0 in the logs. Set this to false to disable masking and log the real client IP. Defaults to true."
  default     = true
}

variable "local_authentication_enabled" {
  type        = bool
  description = "(Optional) Whether Non-Azure AD based Auth is enabled. Defaults to true."
  default     = true
}

variable "internet_ingestion_enabled" {
  type        = bool
  description = "(Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to true."
  default     = true
}

variable "internet_query_enabled" {
  type        = bool
  description = "(Optional) Should the Application Insights component support querying over the Public Internet? Defaults to true."
  default     = true
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
  (Optional) A mapping of tags which should be assigned to the Application Insights component

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
