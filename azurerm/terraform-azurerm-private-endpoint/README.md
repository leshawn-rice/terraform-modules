# terraform-azurerm-private-endpoint

Creates a Private Endpoint and, optionally, registers it in a Private DNS Zone Group.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "private_endpoint" {
  source  = "app.terraform.io/leshawn-rice/private-endpoint/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location
  subnet_id           = module.subnet.id

  private_service_connection = {
    name                           = "${module.storage.name}-blob"
    private_connection_resource_id = module.storage.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group = {
    name                 = "default"
    private_dns_zone_ids = [module.private_dns_zone.id]
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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Private Endpoint. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Private Endpoint should exist. Changing this forces a new Private Endpoint to be created. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Private Endpoint. Changing this forces a new Private Endpoint to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | (Optional) The custom name of the Network Interface attached to the Private Endpoint. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_private_service_connection"></a> [private\_service\_connection](#input\_private\_service\_connection) | (Required) A private\_service\_connection block:<br/>    name                           - (Required) Specifies the Name of the Private Service Connection.<br/>    private\_connection\_resource\_id - (Required) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to.<br/>    subresource\_names              - (Optional) A list of subresource names which the Private Endpoint is able to connect to, e.g. ["blob"], ["queue"], ["sites"], ["Sql"], ["vault"].<br/>    is\_manual\_connection           - (Optional) Does the Private Endpoint require manual approval from the remote resource owner? Defaults to false.<br/>    request\_message                - (Optional) A message passed to the owner of the remote resource when the Private Endpoint attempts to establish a manual connection. | <pre>object({<br/>    name                           = string<br/>    private_connection_resource_id = string<br/>    subresource_names              = optional(list(string))<br/>    is_manual_connection           = optional(bool, false)<br/>    request_message                = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | (Optional) A private\_dns\_zone\_group block:<br/>    name                 - (Required) Specifies the Name of the Private DNS Zone Group.<br/>    private\_dns\_zone\_ids - (Required) Specifies the list of Private DNS Zone IDs which the DNS records for this Private Endpoint should be registered in. | <pre>object({<br/>    name                 = string<br/>    private_dns_zone_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations) | (Optional) One or more ip\_configuration blocks, used to statically assign the Private Endpoint's IP addresses. Changing this forces a new resource to be created. | <pre>list(object({<br/>    name               = string<br/>    private_ip_address = string<br/>    subresource_name   = optional(string)<br/>    member_name        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Private Endpoint<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Private Endpoint. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private Endpoint. |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The ID of the Network Interface associated with the Private Endpoint. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address associated with the Private Endpoint. |
<!-- END_TF_DOCS -->
