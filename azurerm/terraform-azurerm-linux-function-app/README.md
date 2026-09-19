# terraform-azurerm-linux-function-app

Creates a Linux Function App. The app settings the deployment pipeline rewrites (WEBSITE_RUN_FROM_PACKAGE, WEBSITE_CONTENTSHARE, WEBSITE_CONTENTAZUREFILECONNECTIONSTRING) and the Application Insights hidden-link tag are ignored, so publishing a package does not show up as drift.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "function_app" {
  source  = "app.terraform.io/leshawn-rice/linux-function-app/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location
  service_plan_id     = module.service_plan.id

  storage_account_name       = module.storage.name
  storage_account_access_key = module.storage.primary_access_key

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
  }

  identity = {
    type         = "UserAssigned"
    identity_ids = [module.identity.id]
  }

  site_config = {
    application_stack = {
      python_version = "3.11"
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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Function App. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Function App should exist. Changing this forces a new Function App to be created. | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | (Required) The ID of the App Service Plan within which to create this Function App. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Function App. Changing this forces a new Function App to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Optional) The backend storage account name which will be used by this Function App. | `string` | `null` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | (Optional) The access key which will be used to access the backend storage account for the Function App. Conflicts with storage\_uses\_managed\_identity. | `string` | `null` | no |
| <a name="input_storage_uses_managed_identity"></a> [storage\_uses\_managed\_identity](#input\_storage\_uses\_managed\_identity) | (Optional) Should the Function App use Managed Identity to access the storage account. Conflicts with storage\_account\_access\_key. | `bool` | `null` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A map of key-value pairs for App Settings and custom values. | `map(string)` | `{}` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | (Optional) Can the Function App only be accessed via HTTPS? Defaults to true. | `bool` | `true` | no |
| <a name="input_functions_extension_version"></a> [functions\_extension\_version](#input\_functions\_extension\_version) | (Optional) The runtime version associated with the Function App. Defaults to ~4. | `string` | `"~4"` | no |
| <a name="input_builtin_logging_enabled"></a> [builtin\_logging\_enabled](#input\_builtin\_logging\_enabled) | (Optional) Should built-in logging be enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | (Optional) Should the Function App use Client Certificates? Defaults to false. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Is the Function App enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Should public network access be enabled for the Function App? Defaults to true. | `bool` | `true` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | (Optional) The subnet ID which will be used by this Function App for regional virtual network integration. | `string` | `null` | no |
| <a name="input_key_vault_reference_identity_id"></a> [key\_vault\_reference\_identity\_id](#input\_key\_vault\_reference\_identity\_id) | (Optional) The User Assigned Identity ID used for accessing Key Vault secrets referenced in App Settings. | `string` | `null` | no |
| <a name="input_ftp_publish_basic_authentication_enabled"></a> [ftp\_publish\_basic\_authentication\_enabled](#input\_ftp\_publish\_basic\_authentication\_enabled) | (Optional) Should the default FTP Basic Authentication publishing profile be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_webdeploy_publish_basic_authentication_enabled"></a> [webdeploy\_publish\_basic\_authentication\_enabled](#input\_webdeploy\_publish\_basic\_authentication\_enabled) | (Optional) Should the default WebDeploy Basic Authentication publishing credentials be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block:<br/>    type         - (Required) SystemAssigned, UserAssigned or 'SystemAssigned, UserAssigned'.<br/>    identity\_ids - (Optional) A list of User Assigned Identity IDs. Required when type includes UserAssigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | (Required) The site\_config block for the Function App, including the Python runtime version and CORS settings. | <pre>object({<br/>    always_on                              = optional(bool)<br/>    application_insights_connection_string = optional(string)<br/>    application_insights_key               = optional(string)<br/>    app_scale_limit                        = optional(number)<br/>    elastic_instance_minimum               = optional(number)<br/>    pre_warmed_instance_count              = optional(number)<br/>    health_check_path                      = optional(string)<br/>    http2_enabled                          = optional(bool, true)<br/>    minimum_tls_version                    = optional(string, "1.2")<br/>    ftps_state                             = optional(string, "Disabled")<br/>    vnet_route_all_enabled                 = optional(bool)<br/>    runtime_scale_monitoring_enabled       = optional(bool)<br/>    use_32_bit_worker                      = optional(bool, false)<br/>    worker_count                           = optional(number)<br/>    ip_restriction_default_action          = optional(string)<br/><br/>    application_stack = optional(object({<br/>      python_version = optional(string)<br/>      node_version   = optional(string)<br/>      java_version   = optional(string)<br/>      dotnet_version = optional(string)<br/>    }))<br/><br/>    cors = optional(object({<br/>      allowed_origins     = list(string)<br/>      support_credentials = optional(bool, false)<br/>    }))<br/><br/>    ip_restrictions = optional(list(object({<br/>      name                      = string<br/>      action                    = optional(string, "Allow")<br/>      priority                  = optional(number)<br/>      ip_address                = optional(string)<br/>      service_tag               = optional(string)<br/>      virtual_network_subnet_id = optional(string)<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Function App<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Function App. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Function App. |
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname of the Function App. |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | A comma separated list of outbound IP addresses. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID of the Function App's System Assigned Managed Identity, if enabled. |
<!-- END_TF_DOCS -->
