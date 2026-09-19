# terraform-azurerm-storage-account

Creates a Storage Account together with its blob containers, queues and (optionally) a blob lifecycle management policy.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "storage" {
  source  = "app.terraform.io/leshawn-rice/storage-account/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location

  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false

  containers = {
    "input-aax"      = {}
    "chunked-upload" = {}
  }

  queues = {
    "conversion-queue" = {}
  }

  lifecycle_rules = {
    expire-abandoned-chunks = {
      prefix_match                     = ["chunked-upload/"]
      delete_after_days_since_creation = 1
    }
  }

  application = "freebooks"
  environment = "prod"
}
```

## Provider

Targets the `azurerm` 5.x schema (`>= 5.6.0, < 6.0.0`).

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 5.6.0, < 6.0.0 |

### Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Storage Account. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Storage Account should exist. Changing this forces a new Storage Account to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Storage Account. Changing this forces a new Storage Account to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Optional) Defines the Tier to use for this Storage Account. Valid options are Standard and Premium. Defaults to Standard. | `string` | `"Standard"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | (Optional) Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Defaults to LRS. | `string` | `"LRS"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool. Defaults to Hot. | `string` | `"Hot"` | no |
| <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled) | (Optional) Boolean flag which forces HTTPS if enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | (Optional) The minimum supported TLS version for the Storage Account. The only supported value is TLS1\_2. Defaults to TLS1\_2. | `string` | `"TLS1_2"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | (Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to false. | `bool` | `false` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | (Optional) Indicates whether the Storage Account permits requests to be authorized with the account access key via Shared Key. Defaults to true. | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether the public network access is enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | (Optional) Default to Microsoft Entra authorization in the Azure portal when accessing the Storage Account. Defaults to false. | `bool` | `false` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | (Optional) Should cross Tenant replication be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | (Optional) Is Hierarchical Namespace enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| <a name="input_local_user_enabled"></a> [local\_user\_enabled](#input\_local\_user\_enabled) | (Optional) Is Local User Enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled) | (Optional) Boolean, enable SFTP for the Storage Account. Defaults to false. | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block:<br/>    type         - (Required) SystemAssigned, UserAssigned or 'SystemAssigned, UserAssigned'.<br/>    identity\_ids - (Optional) A list of User Assigned Identity IDs. Required when type includes UserAssigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | (Optional) A blob\_properties block, used to configure soft delete, versioning and CORS for the Blob service. | <pre>object({<br/>    versioning_enabled                 = optional(bool, false)<br/>    change_feed_enabled                = optional(bool, false)<br/>    last_access_time_enabled           = optional(bool, false)<br/>    delete_retention_in_days           = optional(number)<br/>    container_delete_retention_in_days = optional(number)<br/>    cors_rules = optional(list(object({<br/>      allowed_headers    = list(string)<br/>      allowed_methods    = list(string)<br/>      allowed_origins    = list(string)<br/>      exposed_headers    = list(string)<br/>      max_age_in_seconds = number<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | (Optional) A network\_rules block:<br/>    default\_action             - (Required) Specifies the default action of allow or deny when no other rules match. Defaults to Deny.<br/>    bypass                     - (Optional) Which traffic can bypass the network rules. Possible values are any combination of Logging, Metrics, AzureServices and None.<br/>    ip\_rules                   - (Optional) List of public IP or IP ranges in CIDR format which are allowed to access the Storage Account.<br/>    virtual\_network\_subnet\_ids - (Optional) A list of virtual network subnet IDs which are allowed to access the Storage Account. | <pre>object({<br/>    default_action             = optional(string, "Deny")<br/>    bypass                     = optional(list(string), ["AzureServices"])<br/>    ip_rules                   = optional(list(string), [])<br/>    virtual_network_subnet_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | (Optional) A map of Blob containers to create, keyed by container name:<br/>    container\_access\_type - (Optional) The Access Level configured for this Container. Possible values are blob, container and private. Defaults to private.<br/>    metadata              - (Optional) A mapping of MetaData for this Container. | <pre>map(object({<br/>    container_access_type = optional(string, "private")<br/>    metadata              = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_queues"></a> [queues](#input\_queues) | (Optional) A map of Storage Queues to create, keyed by queue name. | <pre>map(object({<br/>    metadata = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | (Optional) A map of Blob lifecycle management rules, keyed by rule name. Used to expire temporary artefacts such as<br/>  upload chunks and converted output files. | <pre>map(object({<br/>    enabled                                    = optional(bool, true)<br/>    prefix_match                               = optional(set(string))<br/>    blob_types                                 = optional(list(string), ["blockBlob"])<br/>    delete_after_days_since_creation           = optional(number)<br/>    delete_after_days_since_modification       = optional(number)<br/>    tier_to_cool_after_days_since_modification = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Storage Account<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Storage Account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Account. |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_primary_queue_endpoint"></a> [primary\_queue\_endpoint](#output\_primary\_queue\_endpoint) | The endpoint URL for queue storage in the primary location. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the Storage Account. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID of the Storage Account's managed identity, if one is configured. |
| <a name="output_container_names"></a> [container\_names](#output\_container\_names) | The names of the Blob containers created in this Storage Account. |
| <a name="output_queue_names"></a> [queue\_names](#output\_queue\_names) | The names of the Storage Queues created in this Storage Account. |
<!-- END_TF_DOCS -->
