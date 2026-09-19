# terraform-azurerm-key-vault

Creates an RBAC-authorized Key Vault and, optionally, the secrets it holds. Secret values are only used on creation: changes are ignored afterwards so secrets can be rotated outside terraform without producing a diff.

Naming and tagging follow the house convention: pass `name` to set the name explicitly, or leave it out and the
[standard-naming](https://registry.terraform.io/modules/leshawn-rice/standard-naming/azurerm/latest) module builds one
from `application`, `environment`, `location`, `business_unit`, `workload` and `instance_number`. Pass `tags` to set tags
explicitly, or leave it out and the `tags` module builds them.

## Usage

```hcl
module "key_vault" {
  source  = "app.terraform.io/leshawn-rice/key-vault/azurerm"
  version = "1.0.0"

  resource_group_name = module.resource_group.name
  location            = var.location

  purge_protection_enabled = true

  secrets = {
    "jwt-secret-key" = {
      value        = var.jwt_secret_key
      content_type = "JWT signing key"
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
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Key Vault. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Key Vault should exist. Changing this forces a new Key Vault to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Key Vault. Changing this forces a new Key Vault to be created.<br/><br/>  If 'name' is not passed, the 'standard-naming' module will be called to create a name | `string` | `null` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Optional) The Azure Active Directory tenant ID that should be used for authenticating requests to the Key Vault. Defaults to the tenant of the provider credentials. | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The Name of the SKU used for this Key Vault. Possible values are standard and premium. Defaults to standard. | `string` | `"standard"` | no |
| <a name="input_rbac_authorization_enabled"></a> [rbac\_authorization\_enabled](#input\_rbac\_authorization\_enabled) | (Optional) Should Azure RBAC be used for authorization of data actions instead of access policies? Defaults to true. | `bool` | `true` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | (Optional) Is Purge Protection enabled for this Key Vault? Once enabled it cannot be disabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | (Optional) The number of days that items should be retained for once soft-deleted. Possible values are between 7 and 90. Defaults to 7. | `number` | `7` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | (Optional) Should Azure Virtual Machines be permitted to retrieve certificates stored as secrets from the Key Vault? Defaults to false. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | (Optional) Should Azure Disk Encryption be permitted to retrieve secrets and unwrap keys from the Key Vault? Defaults to false. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | (Optional) Should Azure Resource Manager be permitted to retrieve secrets from the Key Vault? Defaults to false. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for this Key Vault. Defaults to true. | `bool` | `true` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | (Optional) A network\_acls block:<br/>    bypass                     - (Required) Which traffic can bypass the network rules. Possible values are AzureServices and None.<br/>    default\_action             - (Required) The default action when no rule matches. Possible values are Allow and Deny.<br/>    ip\_rules                   - (Optional) One or more IP addresses, or CIDR blocks, which should be able to access the Key Vault.<br/>    virtual\_network\_subnet\_ids - (Optional) One or more Subnet IDs which should be able to access the Key Vault. | <pre>object({<br/>    bypass                     = optional(string, "AzureServices")<br/>    default_action             = optional(string, "Deny")<br/>    ip_rules                   = optional(list(string))<br/>    virtual_network_subnet_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | (Optional) A map of secrets to create in the Key Vault, keyed by secret name. The 'value' is only used on creation;<br/>  subsequent changes to the value are ignored so that secrets can be rotated outside of Terraform. | <pre>map(object({<br/>    value           = string<br/>    content_type    = optional(string)<br/>    expiration_date = optional(string)<br/>    not_before_date = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Key Vault<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Key Vault. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault. |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
| <a name="output_secret_ids"></a> [secret\_ids](#output\_secret\_ids) | A map of secret name to the versionless ID of the created secret. |
| <a name="output_secret_versionless_ids"></a> [secret\_versionless\_ids](#output\_secret\_versionless\_ids) | A map of secret name to the versionless ID of the created secret, suitable for Key Vault references in App Settings. |
<!-- END_TF_DOCS -->
