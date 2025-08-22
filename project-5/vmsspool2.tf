# resource "azurerm_windows_virtual_machine_scale_set" "windows_vmss" {
#   name                 = var.vmss.windows_vmss_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   location             = azurerm_resource_group.rg.location
#   admin_password       = var.vm_password
#   admin_username       = var.vmss.admin_username
#   instances            = var.vmss.instances
#   sku                  = var.vmss.sku
#   computer_name_prefix = var.vmss.computer_name_prefix

#   overprovision                                     = var.vmss.overprovision
#   upgrade_mode                                      = var.vmss.upgrade_mode
#   do_not_run_extensions_on_overprovisioned_machines = var.vmss.do_not_run_extensions_on_overprovisioned_machines
#   enable_automatic_updates                          = var.vmss.windows_enable_automatic_updates
#   extension_operations_enabled                      = var.vmss.extension_operations_enabled
#   provision_vm_agent                                = var.vmss.provision_vm_agent
#   timezone                                          = var.vmss.windows_timezone
#   health_probe_id                                   = azurerm_lb_probe.int_lb_probe.id
#   zones                                             = try(var.vmss.zones, var.availability_zones)

#   dynamic "network_interface" {
#     for_each = var.vmss.int_lb_network_interface
#     content {
#       name    = network_interface.value.name
#       primary = network_interface.value.primary
#       ip_configuration {
#         name                                   = network_interface.value.ip_configuration_name
#         subnet_id                              = data.azurerm_subnet.int_lb_subnet.id
#         load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.int_lb_backEnd_pool.id]
#         version                                = network_interface.value.version
#       }
#     }
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2022-datacenter-azure-edition"
#     version   = "latest"
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "StandardSSD_LRS"
#   }

#   automatic_os_upgrade_policy {
#     disable_automatic_rollback  = true
#     enable_automatic_os_upgrade = true
#   }

#   automatic_instance_repair {
#     enabled      = true
#     grace_period = "PT10M"
#     action       = "Reimage"
#   }

#   boot_diagnostics {
#     storage_account_uri = var.vmss.boot_diagnostics.storage_account_uri
#   }

#   scale_in {
#     rule                   = "Default"
#     force_deletion_enabled = false
#   }

#   rolling_upgrade_policy {
#     max_batch_instance_percent              = 50
#     max_unhealthy_instance_percent          = 100
#     max_unhealthy_upgraded_instance_percent = 100
#     pause_time_between_batches              = "PT5S" # 5 seconds (PT10M signifies 10 minutes)
#     maximum_surge_instances_enabled         = true   # Create new virtual machines to upgrade the scale set, 
#     # rather than updating the existing virtual machines. overprovision must be set to false when maximum_surge_instances_enabled is specified.
#   }

#   lifecycle {
#     ignore_changes = [instances]
#   }
# }