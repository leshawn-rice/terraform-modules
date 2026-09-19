variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Private Endpoint."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Private Endpoint should exist. Changing this forces a new Private Endpoint to be created."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Private Endpoint. Changing this forces a new Private Endpoint to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "custom_network_interface_name" {
  type        = string
  description = "(Optional) The custom name of the Network Interface attached to the Private Endpoint. Changing this forces a new resource to be created."
  default     = null
}

variable "private_service_connection" {
  type = object({
    name                           = string
    private_connection_resource_id = string
    subresource_names              = optional(list(string))
    is_manual_connection           = optional(bool, false)
    request_message                = optional(string)
  })
  description = <<DESCRIPTION
  (Required) A private_service_connection block:
    name                           - (Required) Specifies the Name of the Private Service Connection.
    private_connection_resource_id - (Required) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to.
    subresource_names              - (Optional) A list of subresource names which the Private Endpoint is able to connect to, e.g. ["blob"], ["queue"], ["sites"], ["Sql"], ["vault"].
    is_manual_connection           - (Optional) Does the Private Endpoint require manual approval from the remote resource owner? Defaults to false.
    request_message                - (Optional) A message passed to the owner of the remote resource when the Private Endpoint attempts to establish a manual connection.
  DESCRIPTION
}

variable "private_dns_zone_group" {
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
  description = <<DESCRIPTION
  (Optional) A private_dns_zone_group block:
    name                 - (Required) Specifies the Name of the Private DNS Zone Group.
    private_dns_zone_ids - (Required) Specifies the list of Private DNS Zone IDs which the DNS records for this Private Endpoint should be registered in.
  DESCRIPTION
  default     = null
}

variable "ip_configurations" {
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = optional(string)
    member_name        = optional(string)
  }))
  description = "(Optional) One or more ip_configuration blocks, used to statically assign the Private Endpoint's IP addresses. Changing this forces a new resource to be created."
  default     = []
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
  (Optional) A mapping of tags which should be assigned to the Private Endpoint

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
