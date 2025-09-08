resource "azurerm_linux_virtual_machine_scale_set" "backend2" {
  name                            = "Backend-2"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  admin_username                  = "adminuser"
  instances                       = 1
  sku                             = "Standard_B2s"
  disable_password_authentication = true
  computer_name_prefix            = "backend-2"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.root}/../SSH Keys/ssh_keys.pub")
  }

  overprovision                                     = true
  upgrade_mode                                      = "Manual"
  do_not_run_extensions_on_overprovisioned_machines = false
  extension_operations_enabled                      = true
  provision_vm_agent                                = true
  zones                                             = [1, 2, 3]

  network_interface {
    name    = "linux-nic"
    primary = true
    ip_configuration {
      name      = "linux-nic-config"
      subnet_id = azurerm_subnet.backend.id
      version   = "IPv4"
      application_gateway_backend_address_pool_ids = [
        for pool in azurerm_application_gateway.appGW.backend_address_pool : pool.id
        if pool.name == "${local.backend_address_pool_name}-videos"
      ]
    }
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  # automatic_os_upgrade_policy {
  #   disable_automatic_rollback  = true
  #   enable_automatic_os_upgrade = true
  # }

  # automatic_instance_repair {
  #   enabled      = true
  #   grace_period = "PT10M"
  #   action       = "Reimage"
  # }

  boot_diagnostics {
    storage_account_uri = null
  }

  scale_in {
    rule                   = "Default"
    force_deletion_enabled = false
  }

  # rolling_upgrade_policy {
  #   max_batch_instance_percent              = 50
  #   max_unhealthy_instance_percent          = 100
  #   max_unhealthy_upgraded_instance_percent = 100
  #   pause_time_between_batches              = "PT5S" # 5 seconds (PT10M signifies 10 minutes)
  #   maximum_surge_instances_enabled         = true   # Create new virtual machines to upgrade the scale set, 
  #   # rather than updating the existing virtual machines. overprovision must be set to false when maximum_surge_instances_enabled is specified.
  # }

  lifecycle {
    ignore_changes = [instances]
  }
}

