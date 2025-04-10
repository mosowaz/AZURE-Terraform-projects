resource "azurerm_windows_virtual_machine_scale_set" "windows_vmss" {
  for_each = var.vmss

  name                = each.value.windows_vmss
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  admin_password      = var.vm_password
  admin_username      = each.value.admin_username
  instances           = each.value.instances
  sku                 = each.value.sku

  upgrade_mode                                      = each.value.upgrade_mode
  do_not_run_extensions_on_overprovisioned_machines = each.value.do_not_run_extensions_on_overprovisioned_machines
  enable_automatic_updates                          = each.value.enable_automatic_updates
  extension_operations_enabled                      = each.value.extension_operations_enabled
  provision_vm_agent                                = each.value.provision_vm_agent
  timezone                                          = each.value.timezone
  health_probe_id                                   = each.value.int_lb_health_probe_id
  zones                                             = try(each.value.zones, var.availability_zones)

  dynamic "network_interface" {
    for_each = var.vmss.int_lb_network_interface
    content {
      name    = network_interface.value.name
      primary = network_interface.value.primary
      ip_configuration {
        name      = network_interface.value.ip_configuration_name
        subnet_id = network_interface.value.subnet_id
        version   = network_interface.value.version
      }
    }
  }

  source_image_reference {
    publisher = each.value.windows_source_image_reference.publisher
    offer     = each.value.windows_source_image_reference.offer
    sku       = each.value.windows_source_image_reference.sku
    version   = each.value.windows_source_image_reference.version
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = each.value.automatic_os_upgrade_policy.disable_automatic_rollback
    enable_automatic_os_upgrade = each.value.automatic_os_upgrade_policy.enable_automatic_os_upgrade
  }

  automatic_instance_repair {
    enabled      = each.value.automatic_instance_repair.enabled
    grace_period = each.value.automatic_instance_repair.grace_period
  }

  boot_diagnostics {
    storage_account_uri = each.value.boot_diagnostics.storage_account_uri
  }

  extension {
    name                       = each.value.extension.name
    publisher                  = each.value.extension.publisher
    type                       = each.value.extension.type
    type_handler_version       = each.value.extension.type_handler_version
    auto_upgrade_minor_version = each.value.extension.auto_upgrade_minor_version
    settings                   = each.value.extension.settings
    protected_settings         = each.value.extension.protected_settings
    provision_after_extensions = each.value.provision_after_extensions
  }

  identity {
    type         = each.value.identity.type
    identity_ids = each.value.identity.identity_ids
  }

  scale_in {
    rule                   = each.value.scale_in.rule
    force_deletion_enabled = each.value.scale_in.force_deletion_enabled
  }
}