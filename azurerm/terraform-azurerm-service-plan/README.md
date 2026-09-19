# terraform-azurerm-service-plan

Creates an App Service Plan. Private endpoints and regional VNet integration require an Elastic Premium (EP1+) or Premium SKU.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "service_plan" {
  source  = "app.terraform.io/leshawn-rice/service-plan/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location

  os_type  = "Linux"
  sku_name = "EP1"

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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Service Plan. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Service Plan should exist. Changing this forces a new Service Plan to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Service Plan. Changing this forces a new Service Plan to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The O/S type for the App Services to be hosted in this plan. Possible values are Windows, Linux and WindowsContainer. Defaults to Linux. | `string` | `"Linux"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P0v3, P1v3,<br/>  P2v3, P3v3, S1, S2, S3, SHARED, Y1 (consumption), EP1, EP2 and EP3 (elastic premium), and FC1 (flex consumption). | `string` | `"EP1"` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | (Optional) The number of Workers (instances) to be allocated. | `number` | `null` | no |
| <a name="input_maximum_elastic_worker_count"></a> [maximum\_elastic\_worker\_count](#input\_maximum\_elastic\_worker\_count) | (Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU. | `number` | `null` | no |
| <a name="input_per_site_scaling_enabled"></a> [per\_site\_scaling\_enabled](#input\_per\_site\_scaling\_enabled) | (Optional) Should Per Site Scaling be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_zone_balancing_enabled"></a> [zone\_balancing\_enabled](#input\_zone\_balancing\_enabled) | (Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Service Plan<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Service Plan. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Service Plan. |
| <a name="output_kind"></a> [kind](#output\_kind) | A string representing the Kind of Service Plan. |
<!-- END_TF_DOCS -->
