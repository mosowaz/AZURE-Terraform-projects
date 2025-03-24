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
| [azurerm_network_security_group.hub-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.spoke1-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.spoke2-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.hub-rule1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.hub-rule2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.spoke1-rule](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.spoke2-rule](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_security_rule) | resource |
| [azurerm_resource_group.rg1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/resource_group) | resource |
| [azurerm_route_table.spoke1-2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/route_table) | resource |
| [azurerm_route_table.spoke2-1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/route_table) | resource |
| [azurerm_subnet_network_security_group_association.hub-rule-association](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.spoke1-rule-association](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.spoke2-rule-association](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.spoke1-association](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.spoke2-association](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/subnet_route_table_association) | resource |
| [azurerm_network_security_group.hub-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/network_security_group) | data source |
| [azurerm_network_security_group.spoke1-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/network_security_group) | data source |
| [azurerm_network_security_group.spoke2-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/network_security_group) | data source |
| [azurerm_resource_group.net_rg1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.net_rg2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/resource_group) | data source |
| [azurerm_route_table.spoke1-2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/route_table) | data source |
| [azurerm_route_table.spoke2-1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/route_table) | data source |
| [azurerm_subnet.subnet1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet3](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub_address_prefix"></a> [hub\_address\_prefix](#input\_hub\_address\_prefix) | n/a | `string` | `"10.0.1.0/24"` | no |
| <a name="input_hub_ip"></a> [hub\_ip](#input\_hub\_ip) | n/a | `string` | `"10.0.1.11"` | no |
| <a name="input_lab_tag"></a> [lab\_tag](#input\_lab\_tag) | n/a | `string` | `"rt_table-nsg"` | no |
| <a name="input_location1"></a> [location1](#input\_location1) | n/a | `string` | `"canadacentral"` | no |
| <a name="input_location2"></a> [location2](#input\_location2) | n/a | `string` | `"canadaeast"` | no |
| <a name="input_mypublic-ip"></a> [mypublic-ip](#input\_mypublic-ip) | n/a | `string` | n/a | yes |
| <a name="input_rt-spoke1-2"></a> [rt-spoke1-2](#input\_rt-spoke1-2) | n/a | `string` | `"spoke1-to-spoke2"` | no |
| <a name="input_rt-spoke2-1"></a> [rt-spoke2-1](#input\_rt-spoke2-1) | n/a | `string` | `"spoke2-to-spoke1"` | no |
| <a name="input_spoke1_address_prefix"></a> [spoke1\_address\_prefix](#input\_spoke1\_address\_prefix) | n/a | `string` | `"172.16.1.0/24"` | no |
| <a name="input_spoke2_address_prefix"></a> [spoke2\_address\_prefix](#input\_spoke2\_address\_prefix) | n/a | `string` | `"192.168.1.0/24"` | no |

## Outputs

No outputs.
