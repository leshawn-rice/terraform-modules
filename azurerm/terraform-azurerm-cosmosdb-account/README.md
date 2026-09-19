# terraform-azurerm-cosmosdb-account

Creates a CosmosDB account plus its SQL databases and containers. Databases and containers are declared as one nested map, so a whole data model can be expressed in a single module call.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "cosmosdb" {
  source  = "app.terraform.io/leshawn-rice/cosmosdb-account/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location

  capabilities = ["EnableServerless"]

  geo_locations = [{
    location          = var.location
    failover_priority = 0
  }]

  databases = {
    freebooks = {
      containers = {
        users           = { partition_key_paths = ["/id"] }
        conversion_jobs = { partition_key_paths = ["/user_id"] }
      }
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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the CosmosDB Account. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the CosmosDB Account should exist. Changing this forces a new CosmosDB Account to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this CosmosDB Account. Changing this forces a new CosmosDB Account to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_offer_type"></a> [offer\_type](#input\_offer\_type) | (Optional) Specifies the Offer Type to use for this CosmosDB Account. Currently, this can only be set to Standard. | `string` | `"Standard"` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | (Optional) Specifies the Kind of CosmosDB to create. Possible values are GlobalDocumentDB, MongoDB and Parse. Defaults to GlobalDocumentDB. | `string` | `"GlobalDocumentDB"` | no |
| <a name="input_consistency_policy"></a> [consistency\_policy](#input\_consistency\_policy) | (Optional) A consistency\_policy block:<br/>    consistency\_level       - (Required) The Consistency Level to use. Possible values are BoundedStaleness, Eventual, Session, Strong and ConsistentPrefix. Defaults to Session.<br/>    max\_interval\_in\_seconds - (Optional) Only applicable when consistency\_level is BoundedStaleness.<br/>    max\_staleness\_prefix    - (Optional) Only applicable when consistency\_level is BoundedStaleness. | <pre>object({<br/>    consistency_level       = optional(string, "Session")<br/>    max_interval_in_seconds = optional(number)<br/>    max_staleness_prefix    = optional(number)<br/>  })</pre> | `{}` | no |
| <a name="input_geo_locations"></a> [geo\_locations](#input\_geo\_locations) | (Required) One or more geo\_location blocks describing the geographic locations the data is replicated to. | <pre>list(object({<br/>    location          = string<br/>    failover_priority = number<br/>    zone_redundant    = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | (Optional) A list of CosmosDB capabilities to enable, for example EnableServerless or EnableTable. | `list(string)` | `[]` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | (Optional) Enable automatic failover for this CosmosDB Account. Defaults to false. | `bool` | `false` | no |
| <a name="input_multiple_write_locations_enabled"></a> [multiple\_write\_locations\_enabled](#input\_multiple\_write\_locations\_enabled) | (Optional) Enable multiple write locations for this CosmosDB Account. Defaults to false. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether or not public network access is allowed for this CosmosDB Account. Defaults to true. | `bool` | `true` | no |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | (Optional) Enables virtual network filtering for this CosmosDB Account. Defaults to false. | `bool` | `false` | no |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | (Optional) A list of Subnet IDs which should be able to access this CosmosDB Account. Requires is\_virtual\_network\_filter\_enabled to be true. | `list(string)` | `[]` | no |
| <a name="input_ip_range_filter"></a> [ip\_range\_filter](#input\_ip\_range\_filter) | (Optional) A set of IP addresses or CIDR blocks to be allowed through the firewall. | `set(string)` | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | (Optional) Whether local authentication (account keys) is enabled. Set to false to ensure only Entra ID can be used. Defaults to true. | `bool` | `true` | no |
| <a name="input_free_tier_enabled"></a> [free\_tier\_enabled](#input\_free\_tier\_enabled) | (Optional) Enable the Free Tier pricing option. Only one free tier account is permitted per subscription. Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| <a name="input_minimal_tls_version"></a> [minimal\_tls\_version](#input\_minimal\_tls\_version) | (Optional) Specifies the minimal TLS version for the CosmosDB Account. The only supported value is Tls12. Defaults to Tls12. | `string` | `"Tls12"` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | (Optional) A backup block:<br/>    type                - (Required) The type of the backup. Possible values are Continuous and Periodic.<br/>    interval\_in\_minutes - (Optional) The interval in minutes between two backups, only applicable to Periodic backups.<br/>    retention\_in\_hours  - (Optional) The time in hours that each backup is retained, only applicable to Periodic backups.<br/>    storage\_redundancy  - (Optional) The storage redundancy used to store backups, only applicable to Periodic backups. | <pre>object({<br/>    type                = string<br/>    interval_in_minutes = optional(number)<br/>    retention_in_hours  = optional(number)<br/>    storage_redundancy  = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block:<br/>    type         - (Required) SystemAssigned, UserAssigned or 'SystemAssigned, UserAssigned'.<br/>    identity\_ids - (Optional) A list of User Assigned Identity IDs. Required when type includes UserAssigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | (Optional) A map of SQL databases to create, keyed by database name. Each database may declare a map of containers,<br/>  keyed by container name:<br/>    partition\_key\_paths - (Required) A list of partition key paths, for example ["/id"].<br/>    throughput          - (Optional) Manually provisioned RU/s. Cannot be set on serverless accounts.<br/>    max\_throughput      - (Optional) Maximum RU/s for autoscale. Cannot be set on serverless accounts.<br/>    default\_ttl         - (Optional) The default time to live for items in the container, in seconds.<br/>    unique\_key\_paths    - (Optional) A list of unique key path lists. | <pre>map(object({<br/>    throughput     = optional(number)<br/>    max_throughput = optional(number)<br/>    containers = optional(map(object({<br/>      partition_key_paths   = list(string)<br/>      partition_key_version = optional(number)<br/>      throughput            = optional(number)<br/>      max_throughput        = optional(number)<br/>      default_ttl           = optional(number)<br/>      unique_key_paths      = optional(list(list(string)), [])<br/>    })), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the CosmosDB Account<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the CosmosDB Account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the CosmosDB Account. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint used to connect to the CosmosDB Account. |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The primary key for the CosmosDB Account. |
| <a name="output_primary_readonly_key"></a> [primary\_readonly\_key](#output\_primary\_readonly\_key) | The primary read-only key for the CosmosDB Account. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID of the CosmosDB Account's managed identity, if one is configured. |
| <a name="output_database_names"></a> [database\_names](#output\_database\_names) | The names of the SQL databases created in this account. |
| <a name="output_container_ids"></a> [container\_ids](#output\_container\_ids) | A map of '<database>/<container>' to the ID of the created SQL container. |
<!-- END_TF_DOCS -->
