variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Key Vault."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Key Vault should exist. Changing this forces a new Key Vault to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Key Vault. Changing this forces a new Key Vault to be created.

  If 'name' is not passed, the 'standard-naming' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "(Optional) The Azure Active Directory tenant ID that should be used for authenticating requests to the Key Vault. Defaults to the tenant of the provider credentials."
  default     = null
}

variable "sku_name" {
  type        = string
  description = "(Optional) The Name of the SKU used for this Key Vault. Possible values are standard and premium. Defaults to standard."
  default     = "standard"
}

variable "rbac_authorization_enabled" {
  type        = bool
  description = "(Optional) Should Azure RBAC be used for authorization of data actions instead of access policies? Defaults to true."
  default     = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "(Optional) Is Purge Protection enabled for this Key Vault? Once enabled it cannot be disabled. Defaults to false."
  default     = false
}

variable "soft_delete_retention_days" {
  type        = number
  description = "(Optional) The number of days that items should be retained for once soft-deleted. Possible values are between 7 and 90. Defaults to 7."
  default     = 7
}

variable "enabled_for_deployment" {
  type        = bool
  description = "(Optional) Should Azure Virtual Machines be permitted to retrieve certificates stored as secrets from the Key Vault? Defaults to false."
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(Optional) Should Azure Disk Encryption be permitted to retrieve secrets and unwrap keys from the Key Vault? Defaults to false."
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "(Optional) Should Azure Resource Manager be permitted to retrieve secrets from the Key Vault? Defaults to false."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Key Vault. Defaults to true."
  default     = true
}

variable "network_acls" {
  type = object({
    bypass                     = optional(string, "AzureServices")
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  description = <<DESCRIPTION
  (Optional) A network_acls block:
    bypass                     - (Required) Which traffic can bypass the network rules. Possible values are AzureServices and None.
    default_action             - (Required) The default action when no rule matches. Possible values are Allow and Deny.
    ip_rules                   - (Optional) One or more IP addresses, or CIDR blocks, which should be able to access the Key Vault.
    virtual_network_subnet_ids - (Optional) One or more Subnet IDs which should be able to access the Key Vault.
  DESCRIPTION
  default     = null
}

variable "secrets" {
  type = map(object({
    value           = string
    content_type    = optional(string)
    expiration_date = optional(string)
    not_before_date = optional(string)
  }))
  description = <<DESCRIPTION
  (Optional) A map of secrets to create in the Key Vault, keyed by secret name. The 'value' is only used on creation;
  subsequent changes to the value are ignored so that secrets can be rotated outside of Terraform.
  DESCRIPTION
  default     = {}
  sensitive   = true
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
  (Optional) A mapping of tags which should be assigned to the Key Vault

  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}
