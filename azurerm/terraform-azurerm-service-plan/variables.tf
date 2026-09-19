variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Service Plan."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Service Plan should exist. Changing this forces a new Service Plan to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Service Plan. Changing this forces a new Service Plan to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "os_type" {
  type        = string
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values are Windows, Linux and WindowsContainer. Defaults to Linux."
  default     = "Linux"
}

variable "sku_name" {
  type        = string
  description = <<DESCRIPTION
  (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P0v3, P1v3,
  P2v3, P3v3, S1, S2, S3, SHARED, Y1 (consumption), EP1, EP2 and EP3 (elastic premium), and FC1 (flex consumption).
  DESCRIPTION
  default     = "EP1"
}

variable "worker_count" {
  type        = number
  description = "(Optional) The number of Workers (instances) to be allocated."
  default     = null
}

variable "maximum_elastic_worker_count" {
  type        = number
  description = "(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  default     = null
}

variable "per_site_scaling_enabled" {
  type        = bool
  description = "(Optional) Should Per Site Scaling be enabled. Defaults to false."
  default     = false
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "(Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created."
  default     = false
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
  (Optional) A mapping of tags which should be assigned to the Service Plan

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
