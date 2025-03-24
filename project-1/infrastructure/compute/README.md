## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =4.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.hub-vm](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.spokes-vm](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.hub-nic](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_interface) | resource |
| [azurerm_network_interface.spoke-nic](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/network_interface) | resource |
| [azurerm_public_ip.hub_pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/public_ip) | resource |
| [azurerm_public_ip.spoke1_pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/public_ip) | resource |
| [azurerm_public_ip.spoke2_pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/resources/resource_group) | resource |
| [azurerm_network_interface.hub-nic](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/network_interface) | data source |
| [azurerm_network_interface.spoke-nic](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/network_interface) | data source |
| [azurerm_public_ip.hub_pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/public_ip) | data source |
| [azurerm_public_ip.spoke1_pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/public_ip) | data source |
| [azurerm_public_ip.spoke2_pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.net_rg1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.net_rg2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet1](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet2](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet3](https://registry.terraform.io/providers/hashicorp/azurerm/4.0.1/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub-sshkey"></a> [hub-sshkey](#input\_hub-sshkey) | n/a | `any` | n/a | yes |
| <a name="input_hub-sshkey-pub"></a> [hub-sshkey-pub](#input\_hub-sshkey-pub) | n/a | `any` | n/a | yes |
| <a name="input_location1"></a> [location1](#input\_location1) | n/a | `string` | `"canadacentral"` | no |
| <a name="input_location2"></a> [location2](#input\_location2) | n/a | `string` | `"canadaeast"` | no |
| <a name="input_sp1-sshkey"></a> [sp1-sshkey](#input\_sp1-sshkey) | n/a | `any` | n/a | yes |
| <a name="input_sp1-sshkey-pub"></a> [sp1-sshkey-pub](#input\_sp1-sshkey-pub) | n/a | `any` | n/a | yes |
| <a name="input_sp2-sshkey"></a> [sp2-sshkey](#input\_sp2-sshkey) | n/a | `any` | n/a | yes |
| <a name="input_sp2-sshkey-pub"></a> [sp2-sshkey-pub](#input\_sp2-sshkey-pub) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hub_private_ip"></a> [hub\_private\_ip](#output\_hub\_private\_ip) | n/a |
| <a name="output_hub_public_ip"></a> [hub\_public\_ip](#output\_hub\_public\_ip) | n/a |
| <a name="output_spoke1_public_ip"></a> [spoke1\_public\_ip](#output\_spoke1\_public\_ip) | n/a |
| <a name="output_spoke2_public_ip"></a> [spoke2\_public\_ip](#output\_spoke2\_public\_ip) | n/a |
| <a name="output_spokes_private_ip"></a> [spokes\_private\_ip](#output\_spokes\_private\_ip) | n/a |
