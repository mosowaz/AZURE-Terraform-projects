locals {
  nsg_1_rules = {
    # NSG rule (Allow inbound HTTP/HTTPS) for internal load balancer subnet
    nsg_1_rule_1 = {
      for_each                   = var.nsg-1-rule-1
      name                       = each.value.name
      priority                   = each.value.priority
      direction                  = each.value.direction
      access                     = each.value.access
      protocol                   = each.value.protocol
      source_port_range          = each.value.source_port_range
      destination_port_range     = each.value.destination_port_range
      source_address_prefix      = each.value.source_address_prefix
      destination_address_prefix = each.value.destination_address_prefix
    },
    # NSG rule (Allow inbound RDP) for external load balancer subnet
    nsg_1_rule_2 = {
      name                       = var.nsg-1-rule-2.name
      priority                   = var.nsg-1-rule-2.priority
      direction                  = var.nsg-1-rule-2.direction
      access                     = var.nsg-1-rule-2.access
      protocol                   = var.nsg-1-rule-2.protocol
      source_port_range          = var.nsg-1-rule-2.source_port_range
      destination_port_range     = var.nsg-1-rule-2.destination_port_range
      source_address_prefix      = var.nsg-1-rule-2.source_address_prefix
      destination_address_prefix = var.nsg-1-rule-2.destination_address_prefix
    }
  }

  nsg_2_rules = {
    # NSG rule (Allow inbound HTTP/HTTPS) for external load balancer subnet
    nsg_2_rule_1 = {
      for_each                   = var.nsg-2-rule-1
      name                       = each.value.name
      priority                   = each.value.priority
      direction                  = each.value.direction
      access                     = each.value.access
      protocol                   = each.value.protocol
      source_port_range          = each.value.source_port_range
      destination_port_range     = each.value.destination_port_range
      source_address_prefix      = each.value.source_address_prefix
      destination_address_prefix = each.value.destination_address_prefix
    },
    # NSG rule (Allow inbound SSH) for external load balancer subnet
    nsg_2_rule_2 = {
      name                       = var.nsg-2-rule-2.name
      priority                   = var.nsg-2-rule-2.priority
      direction                  = var.nsg-2-rule-2.direction
      access                     = var.nsg-2-rule-2.access
      protocol                   = var.nsg-2-rule-2.protocol
      source_port_range          = var.nsg-2-rule-2.source_port_range
      destination_port_range     = var.nsg-2-rule-2.destination_port_range
      source_address_prefix      = var.nsg-2-rule-2.source_address_prefix
      destination_address_prefix = var.nsg-2-rule-2.destination_address_prefix
    }
  }
}