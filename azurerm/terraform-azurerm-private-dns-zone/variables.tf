variable "name" {
  type        = string
  description = "(Required) The name of the Private DNS Zone, for example 'privatelink.blob.core.windows.net'. Changing this forces a new Private DNS Zone to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Private DNS Zone."
}

variable "virtual_network_links" {
  type = map(object({
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  description = <<DESCRIPTION
  (Optional) A map of Virtual Network links to create for this zone, keyed by link name:
    virtual_network_id   - (Required) The ID of the Virtual Network that should be linked to the Private DNS Zone.
    registration_enabled - (Optional) Is auto-registration of Virtual Machine records in the zone enabled? Defaults to false.
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
variable "service" {
  type        = string
  description = ""
  default     = null
}

variable "tags" {
  type        = map(string)
  description = <<DESCRIPTION
  (Optional) A mapping of tags which should be assigned to the Private DNS Zone and its links

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
