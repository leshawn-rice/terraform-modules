# terraform-azurerm-static-web-app

Creates a Static Web App and attaches custom domains. The site content itself is uploaded by the Azure/static-web-apps-deploy GitHub Action using the deployment token in the `api_key` output.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "static_web_app" {
  source  = "app.terraform.io/leshawn-rice/static-web-app/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location

  custom_domains = {
    "freemybooks.com"     = { validation_type = "dns-txt-token" }
    "www.freemybooks.com" = { validation_type = "cname-delegation" }
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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Static Web App. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Static Web App should exist. Changing this forces a new Static Web App to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Static Web App. Changing this forces a new Static Web App to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) Specifies the SKU tier of the Static Web App. Possible values are Free or Standard. Defaults to Free. | `string` | `"Free"` | no |
| <a name="input_sku_size"></a> [sku\_size](#input\_sku\_size) | (Optional) Specifies the SKU size of the Static Web App. Possible values are Free or Standard. Defaults to Free. | `string` | `"Free"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A key-value pair of App Settings for the Static Web App's managed API. | `map(string)` | `{}` | no |
| <a name="input_preview_environments_enabled"></a> [preview\_environments\_enabled](#input\_preview\_environments\_enabled) | (Optional) Are preview (staging) environments enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_configuration_file_changes_enabled"></a> [configuration\_file\_changes\_enabled](#input\_configuration\_file\_changes\_enabled) | (Optional) Should changes to the configuration file be permitted? Defaults to true. | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Should public network access be enabled for the Static Web App? Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block:<br/>    type         - (Required) SystemAssigned or UserAssigned.<br/>    identity\_ids - (Optional) A list of User Assigned Identity IDs. Required when type is UserAssigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_basic_auth"></a> [basic\_auth](#input\_basic\_auth) | (Optional) A basic\_auth block:<br/>    password     - (Required) The password for the basic authentication access.<br/>    environments - (Required) The environments to protect. Possible values are AllEnvironments, StagingEnvironments and Both. | <pre>object({<br/>    password     = string<br/>    environments = string<br/>  })</pre> | `null` | no |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | (Optional) A map of custom domains to attach to the Static Web App, keyed by domain name:<br/>    validation\_type - (Optional) One of cname-delegation or dns-txt-token. Defaults to cname-delegation.<br/><br/>  The DNS records must exist before the apply completes, otherwise validation times out. | <pre>map(object({<br/>    validation_type = optional(string, "cname-delegation")<br/>  }))</pre> | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Static Web App<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Static Web App. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Static Web App. |
| <a name="output_default_host_name"></a> [default\_host\_name](#output\_default\_host\_name) | The default host name of the Static Web App. |
| <a name="output_api_key"></a> [api\_key](#output\_api\_key) | The deployment token of the Static Web App, used by the GitHub Actions workflow. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID of the Static Web App's managed identity, if one is configured. |
<!-- END_TF_DOCS -->
