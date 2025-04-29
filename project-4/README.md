<!-- BEGIN_TF_DOCS -->
[![Build Status](https://dev.azure.com/MosesOwaseye/Load%20Balancers/_apis/build/status%2FDeploy%20Resources?branchName=main)](https://dev.azure.com/MosesOwaseye/Load%20Balancers/_build/latest?definitionId=28&branchName=main)   [![Generate terraform docs](https://github.com/mosowaz/AZURE-Terraform-projects/actions/workflows/project-4-tf-docs.yml/badge.svg?branch=main)](https://github.com/mosowaz/AZURE-Terraform-projects/actions/workflows/project-4-tf-docs.yml)

## Create private/Internal and public/external load balancer with VMSS as backend pool

<p align="center">
  <img src="https://learn.microsoft.com/en-us/azure/load-balancer/media/quickstart-load-balancer-standard-internal-portal/internal-load-balancer-resources.png#lightbox" alt="Internal Load Balancer Resources" width="400">
  <img src="https://learn.microsoft.com/en-us/azure/load-balancer/media/quickstart-load-balancer-standard-public-portal/public-load-balancer-resources.png#lightbox" alt="Public Load Balancer Resources" width="400">
</p>

### Steps
- Create a resource group
- Create a virtual network with two subnets (for each load balancers)
- Create 3 public IPs
- Create private and public load balancers
- Create network security groups (NSGs)
- Create NAT gateway
- Create a bastion host
- Create 2 sets of backend pools ( windows and Linux VMSS)
- Create Autoscale settings for VMSS
- Install IIS (as extention) in Windows
- Install Nginx (as extention) in Linux
- Test both load balancers

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm-res-insights-autoscalesetting"></a> [avm-res-insights-autoscalesetting](#module\_avm-res-insights-autoscalesetting) | git::https://github.com/Azure/terraform-azurerm-avm-res-insights-autoscalesetting.git | f4e7e4b |
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.com/Azure/terraform-azurerm-naming.git | 75d5afae4cb01f4446025e81f76af6b60c1f927b |

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_lb.ext_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb.int_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.ext_lb_backEnd_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool.int_lb_backEnd_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_probe.ext_lb_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_probe.int_lb_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.ext_lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_lb_rule.int_lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine_scale_set.linux_vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.IP-nat_gw_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.bastion-rule-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion-rule-2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion-rule-3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion-rule-4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion-rule-5](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion-rule-6](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion-rule-7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.nsg_1_rule_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.nsg_1_rule_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.nsg_2_rule_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.nsg_2_rule_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.bastion_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.ext_lb_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.nat_gw_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.role1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.role2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.bastion_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.subnet_ext-nat_gw_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.subnet_int-nat_gw_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.nsg-1-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.nsg-2-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.nsg-BastionSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_user_assigned_identity.VMSS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_windows_virtual_machine_scale_set.windows_vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [azuread_service_principal.spn](https://registry.terraform.io/providers/hashicorp/azuread/3.1.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_role_definition.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subnet.ext_lb_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.int_lb_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.VMSS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| <a name="input_autoscale-vmss"></a> [autoscale-vmss](#input\_autoscale-vmss) | AutoScale settings for VMSS | `any` | `{}` |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones to be allocated for zonal resources | `set(string)` | <pre>[<br/>  "1",<br/>  "2",<br/>  "3"<br/>]</pre> |
| <a name="input_bastion_host"></a> [bastion\_host](#input\_bastion\_host) | Bastion host properties | `map` | <pre>{<br/>  "copy_paste_enabled": true,<br/>  "file_copy_enabled": true,<br/>  "ip_connect_enabled": true,<br/>  "name": "Bastion",<br/>  "scale_units": 2,<br/>  "sku": "Standard",<br/>  "subnet": "10.0.3.0/24"<br/>}</pre> |
| <a name="input_bastion_pip"></a> [bastion\_pip](#input\_bastion\_pip) | Bastion host's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "Bastion-Public-IP",<br/>  "sku": "Standard"<br/>}</pre> |
| <a name="input_disable_outbound_snat"></a> [disable\_outbound\_snat](#input\_disable\_outbound\_snat) | (Optional) Is snat enabled for this Load Balancer Rule? | `string` | `"true"` |
| <a name="input_ext_lb"></a> [ext\_lb](#input\_ext\_lb) | Properties of the external load balancer. If Global balancer is required, use sku\_tier = Global | `map` | <pre>{<br/>  "name": "loadbalancer-ext",<br/>  "sku": "Standard",<br/>  "sku_tier": "Regional"<br/>}</pre> |
| <a name="input_ext_lb_pip"></a> [ext\_lb\_pip](#input\_ext\_lb\_pip) | External load balancer's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "ext-lb-public-IP",<br/>  "sku": "Standard"<br/>}</pre> |
| <a name="input_int_lb"></a> [int\_lb](#input\_int\_lb) | Properties of the internal load balancer. If Global balancer is required, use sku\_tier = Global | `map` | <pre>{<br/>  "name": "loadBalancer-int",<br/>  "private_ip_address_allocation": "Dynamic",<br/>  "sku": "Standard",<br/>  "sku_tier": "Regional"<br/>}</pre> |
| <a name="input_lb-rg-location"></a> [lb-rg-location](#input\_lb-rg-location) | resource group location | `string` | `"canadacentral"` |
| <a name="input_lb-rg-name"></a> [lb-rg-name](#input\_lb-rg-name) | resource group name | `string` | `"rg-loadBalancers"` |
| <a name="input_lb_probe_interval_in_seconds"></a> [lb\_probe\_interval\_in\_seconds](#input\_lb\_probe\_interval\_in\_seconds) | (Optional) The interval, in seconds between probes to the backend endpoint for health status. | `string` | `"5"` |
| <a name="input_nat_gw_pip"></a> [nat\_gw\_pip](#input\_nat\_gw\_pip) | Nat gateway's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "Nat-GW-public-IP",<br/>  "sku": "Standard"<br/>}</pre> |
| <a name="input_nsg-1-rule-1"></a> [nsg-1-rule-1](#input\_nsg-1-rule-1) | NSG rule (Allow Inbound HTTP/HTTPS) for internal load balancer subnet | <pre>map(object({<br/>    name                       = string<br/>    priority                   = any<br/>    direction                  = string<br/>    access                     = string<br/>    protocol                   = string<br/>    source_port_range          = string<br/>    destination_port_range     = any<br/>    source_address_prefix      = string<br/>    destination_address_prefix = string<br/>  }))</pre> | <pre>{<br/>  "first": {<br/>    "access": "Allow",<br/>    "destination_address_prefix": "10.0.1.0/24",<br/>    "destination_port_range": 80,<br/>    "direction": "Inbound",<br/>    "name": "allowInbound-HTTP-int1",<br/>    "priority": 200,<br/>    "protocol": "*",<br/>    "source_address_prefix": "VirtualNetwork",<br/>    "source_port_range": "*"<br/>  },<br/>  "second": {<br/>    "access": "Allow",<br/>    "destination_address_prefix": "10.0.1.0/24",<br/>    "destination_port_range": 443,<br/>    "direction": "Inbound",<br/>    "name": "allowInbound-HTTP-int2",<br/>    "priority": 210,<br/>    "protocol": "*",<br/>    "source_address_prefix": "VirtualNetwork",<br/>    "source_port_range": "*"<br/>  }<br/>}</pre> |
| <a name="input_nsg-1-rule-2"></a> [nsg-1-rule-2](#input\_nsg-1-rule-2) | NSG rule (Allow Inbound RDP) for internal load balancer subnet | `map` | <pre>{<br/>  "access": "Allow",<br/>  "destination_address_prefix": "10.0.1.0/24",<br/>  "destination_port_range": 3389,<br/>  "direction": "Inbound",<br/>  "name": "allowInbound-SSH-RDP",<br/>  "priority": 400,<br/>  "protocol": "*",<br/>  "source_address_prefix": "VirtualNetwork",<br/>  "source_port_range": "*"<br/>}</pre> |
| <a name="input_nsg-2-rule-1"></a> [nsg-2-rule-1](#input\_nsg-2-rule-1) | NSG rule (Allow Inbound HTTP/HTTPS) for external load balancer subnet | <pre>map(object({<br/>    name                       = string<br/>    priority                   = any<br/>    direction                  = string<br/>    access                     = string<br/>    protocol                   = string<br/>    source_port_range          = string<br/>    destination_port_range     = any<br/>    source_address_prefix      = string<br/>    destination_address_prefix = string<br/>  }))</pre> | <pre>{<br/>  "first": {<br/>    "access": "Allow",<br/>    "destination_address_prefix": "10.0.2.0/24",<br/>    "destination_port_range": 80,<br/>    "direction": "Inbound",<br/>    "name": "allowInbound-HTTP-ext1",<br/>    "priority": 220,<br/>    "protocol": "*",<br/>    "source_address_prefix": "VirtualNetwork",<br/>    "source_port_range": "*"<br/>  },<br/>  "second": {<br/>    "access": "Allow",<br/>    "destination_address_prefix": "10.0.2.0/24",<br/>    "destination_port_range": 443,<br/>    "direction": "Inbound",<br/>    "name": "allowInbound-HTTP-ext2",<br/>    "priority": 230,<br/>    "protocol": "*",<br/>    "source_address_prefix": "VirtualNetwork",<br/>    "source_port_range": "*"<br/>  }<br/>}</pre> |
| <a name="input_nsg-2-rule-2"></a> [nsg-2-rule-2](#input\_nsg-2-rule-2) | NSG rule (Allow Inbound SSH) for external load balancer subnet | `map` | <pre>{<br/>  "access": "Allow",<br/>  "destination_address_prefix": "10.0.2.0/24",<br/>  "destination_port_range": 22,<br/>  "direction": "Inbound",<br/>  "name": "allowInbound-SSH-RDP",<br/>  "priority": 440,<br/>  "protocol": "*",<br/>  "source_address_prefix": "VirtualNetwork",<br/>  "source_port_range": "*"<br/>}</pre> |
| <a name="input_sshkey-public"></a> [sshkey-public](#input\_sshkey-public) | Public key for Linux VMSS, passed from pipeline variable | `string` | n/a |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | Windows VMSS password value, passed from pipeline variable | `string` | n/a |
| <a name="input_vmss"></a> [vmss](#input\_vmss) | VM backend pools used behind the internal and external load balancers. Look in vmss.tfvars for values | `any` | `{}` |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | virtual network and subnet for loadbalancer backend pools | `map` | <pre>{<br/>  "address_space": "10.0.0.0/16",<br/>  "name": "vnet-lb",<br/>  "subnet_address_prefixes_ext": "10.0.2.0/24",<br/>  "subnet_address_prefixes_int": "10.0.1.0/24",<br/>  "subnet_name_ext": "ext-lb-subnet",<br/>  "subnet_name_int": "int-lb-subnet"<br/>}</pre> |

## Outputs

No outputs.
<!-- END_TF_DOCS -->