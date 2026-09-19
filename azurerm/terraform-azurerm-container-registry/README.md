# terraform-azurerm-container-registry

Creates an Azure Container Registry. Admin credentials are off by default; grant AcrPull to a managed identity instead.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "container_registry" {
  source  = "app.terraform.io/leshawn-rice/container-registry/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location

  sku = "Basic"

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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Container Registry. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Container Registry should exist. Changing this forces a new Container Registry to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Container Registry. Changing this forces a new Container Registry to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU name of the Container Registry. Possible values are Basic, Standard and Premium. Defaults to Basic. | `string` | `"Basic"` | no |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | (Optional) Specifies whether the admin user is enabled. Defaults to false; prefer managed identity based pulls. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for the Container Registry. Defaults to true. | `bool` | `true` | no |
| <a name="input_anonymous_pull_enabled"></a> [anonymous\_pull\_enabled](#input\_anonymous\_pull\_enabled) | (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry. Requires the Standard or Premium SKU. Defaults to false. | `bool` | `false` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | (Optional) Whether zone redundancy is enabled for this Container Registry. Requires the Premium SKU. Defaults to false. | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block:<br/>    type         - (Required) SystemAssigned, UserAssigned or 'SystemAssigned, UserAssigned'.<br/>    identity\_ids - (Optional) A list of User Assigned Identity IDs. Required when type includes UserAssigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_retention_policy_in_days"></a> [retention\_policy\_in\_days](#input\_retention\_policy\_in\_days) | (Optional) The number of days to retain untagged manifests for. Requires the Premium SKU. Defaults to null (policy disabled). | `number` | `null` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Container Registry<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Container Registry. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container Registry. |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | The URL that can be used to log into the Container Registry. |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The Username associated with the Container Registry Admin account, if enabled. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The Password associated with the Container Registry Admin account, if enabled. |
<!-- END_TF_DOCS -->
