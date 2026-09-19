# terraform-azurerm-private-dns-zone

Creates a Private DNS Zone and its Virtual Network links. Zone names for private link are fixed by Azure (for example `privatelink.blob.core.windows.net`), so this module takes `name` directly and does not call the standard-naming module.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "private_dns_zone" {
  source  = "app.terraform.io/leshawn-rice/private-dns-zone/azurerm"
  version = "1.0.0"

  name                = "privatelink.blob.core.windows.net"
  resource_group_name = module.resource_group.name

  virtual_network_links = {
    "vnet-freebooks-001-link" = {
      virtual_network_id = module.virtual_network.id
    }
  }
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
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Private DNS Zone, for example 'privatelink.blob.core.windows.net'. Changing this forces a new Private DNS Zone to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Private DNS Zone. | `string` | n/a | yes |
| <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links) | (Optional) A map of Virtual Network links to create for this zone, keyed by link name:<br/>    virtual\_network\_id   - (Required) The ID of the Virtual Network that should be linked to the Private DNS Zone.<br/>    registration\_enabled - (Optional) Is auto-registration of Virtual Machine records in the zone enabled? Defaults to false. | <pre>map(object({<br/>    virtual_network_id   = string<br/>    registration_enabled = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Private DNS Zone and its links<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Private DNS Zone. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private DNS Zone. |
| <a name="output_virtual_network_link_ids"></a> [virtual\_network\_link\_ids](#output\_virtual\_network\_link\_ids) | A map of link name to the ID of the Private DNS Zone Virtual Network Link. |
<!-- END_TF_DOCS -->
