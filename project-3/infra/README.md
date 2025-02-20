
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 1.13, < 3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.116, < 5 |
| <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) | ~> 0.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.116, < 5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm-res-network-virtualnetwork"></a> [avm-res-network-virtualnetwork](#module\_avm-res-network-virtualnetwork) | Azure/avm-res-network-virtualnetwork/azurerm | n/a |
| <a name="module_network-security-group"></a> [network-security-group](#module\_network-security-group) | Azure/network-security-group/azurerm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet_network_security_group_association.nsg-BastionSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet.BastionSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_BastionSubnet"></a> [BastionSubnet](#input\_BastionSubnet) | n/a | `string` | n/a | yes |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | n/a | `string` | n/a | yes |
| <a name="input_nsg_rule1"></a> [nsg\_rule1](#input\_nsg\_rule1) | n/a | `string` | n/a | yes |
| <a name="input_nsg_rule2"></a> [nsg\_rule2](#input\_nsg\_rule2) | n/a | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | <pre>object({<br/>    name     = string<br/>    location = string<br/>  })</pre> | n/a | yes |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | n/a | <pre>object({<br/>    name          = string<br/>    address_space = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->