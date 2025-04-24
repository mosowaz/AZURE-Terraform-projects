resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  name                            = var.vmss.linux_vmss_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  admin_username                  = var.vmss.admin_username
  instances                       = var.vmss.instances
  sku                             = var.vmss.sku
  disable_password_authentication = true
  computer_name_prefix            = var.vmss.computer_name_prefix

  admin_ssh_key {
    username   = var.vmss.admin_username
    public_key = var.sshkey-public
  }

  upgrade_mode                                      = var.vmss.upgrade_mode
  do_not_run_extensions_on_overprovisioned_machines = var.vmss.do_not_run_extensions_on_overprovisioned_machines
  extension_operations_enabled                      = var.vmss.extension_operations_enabled
  provision_vm_agent                                = var.vmss.provision_vm_agent
  health_probe_id                                   = azurerm_lb_probe.ext_lb_probe.id
  zones                                             = try(var.vmss.zones, var.availability_zones)

  dynamic "network_interface" {
    for_each = var.vmss.ext_lb_network_interface
    content {
      name    = network_interface.value.name
      primary = network_interface.value.primary
      ip_configuration {
        name                                   = network_interface.value.ip_configuration_name
        subnet_id                              = data.azurerm_subnet.ext_lb_subnet.id
        load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.ext_lb_backEnd_pool.id]
        version                                = network_interface.value.version
      }
    }
  }

  source_image_reference {
    publisher = var.vmss.linux_source_image_reference.publisher
    offer     = var.vmss.linux_source_image_reference.offer
    sku       = var.vmss.linux_source_image_reference.sku
    version   = var.vmss.linux_source_image_reference.version
  }

  os_disk {
    caching              = var.vmss.os_disk.caching
    storage_account_type = var.vmss.os_disk.storage_account_type
  }

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = var.vmss.automatic_os_upgrade_policy.disable_automatic_rollback
    enable_automatic_os_upgrade = var.vmss.automatic_os_upgrade_policy.enable_automatic_os_upgrade
  }

  automatic_instance_repair {
    enabled      = var.vmss.automatic_instance_repair.enabled
    grace_period = var.vmss.automatic_instance_repair.grace_period
  }

  boot_diagnostics {
    storage_account_uri = var.vmss.boot_diagnostics.storage_account_uri
  }

  #   extension {
  #     name                       = 
  #     publisher                  = 
  #     type                       = 
  #     type_handler_version       = 
  #     auto_upgrade_minor_version = 
  #     settings                   = 
  #     protected_settings         = 
  #     provision_after_extensions = 
  #   }

  identity {
    type         = var.vmss.identity.type
    identity_ids = [azurerm_user_assigned_identity.VMSS.id]
  }

  scale_in {
    rule                   = var.vmss.scale_in.rule
    force_deletion_enabled = var.vmss.scale_in.force_deletion_enabled
  }

  rolling_upgrade_policy {
    max_batch_instance_percent              = var.vmss.rolling_upgrade_policy.max_batch_instance_percent
    max_unhealthy_instance_percent          = var.vmss.rolling_upgrade_policy.max_unhealthy_instance_percent
    max_unhealthy_upgraded_instance_percent = var.vmss.rolling_upgrade_policy.max_unhealthy_upgraded_instance_percent
    pause_time_between_batches              = var.vmss.rolling_upgrade_policy.pause_time_between_batches
  }

  lifecycle {
    ignore_changes = [instances]
  }

  depends_on = [azurerm_lb_rule.ext_lb_rule]
}