## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =4.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =4.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/resource_group) | resource |
| [azurerm_subnet.subnet1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet3](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.vnet2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.vnet3](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.peering1-2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering1-3](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering2-1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering3-1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network.vnet1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet3](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lab_tag"></a> [lab\_tag](#input\_lab\_tag) | n/a | `string` | `"hub-spoke"` | no |
| <a name="input_location1"></a> [location1](#input\_location1) | n/a | `string` | `"canadacentral"` | no |
| <a name="input_location2"></a> [location2](#input\_location2) | n/a | `string` | `"canadaeast"` | no |
| <a name="input_vnet1"></a> [vnet1](#input\_vnet1) | n/a | <pre>object({<br/>    address_space = string<br/>    vnet_name     = string<br/>    address_prefixes = string<br/>  })</pre> | <pre>{<br/>  "address_prefixes": "10.0.1.0/24",<br/>  "address_space": "10.0.0.0/16",<br/>  "vnet_name": "vnet-1"<br/>}</pre> | no |
| <a name="input_vnet2"></a> [vnet2](#input\_vnet2) | n/a | <pre>object({<br/>    address_space = string<br/>    vnet_name     = string<br/>    address_prefixes = string<br/>  })</pre> | <pre>{<br/>  "address_prefixes": "172.16.1.0/24",<br/>  "address_space": "172.16.0.0/16",<br/>  "vnet_name": "vnet-2"<br/>}</pre> | no |
| <a name="input_vnet3"></a> [vnet3](#input\_vnet3) | n/a | <pre>object({<br/>    address_space = string<br/>    vnet_name     = string<br/>    address_prefixes = string<br/>  })</pre> | <pre>{<br/>  "address_prefixes": "192.168.1.0/24",<br/>  "address_space": "192.168.0.0/16",<br/>  "vnet_name": "vnet-3"<br/>}</pre> | no |

## Outputs

No outputs.
