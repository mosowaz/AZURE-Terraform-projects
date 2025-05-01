vmss = {
  linux_vmss_name      = "Linux-VMs"
  windows_vmss_name    = "Window-VMs"
  admin_username       = "adminuser"
  instances            = 4
  sku                  = "Standard_B2s"
  computer_name_prefix = "vmss"

  overprovision                                     = false    #multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time
  upgrade_mode                                      = "Rolling"
  do_not_run_extensions_on_overprovisioned_machines = false  # (optional) Defaults to false
  windows_enable_automatic_updates                  = false
  extension_operations_enabled                      = true
  provision_vm_agent                                = true
  windows_timezone                                  = "Eastern Standard Time"
  zones                                             = [1, 2]
  health_probe_id                                   = ""

  int_lb_network_interface = {
    nic1 = {
      name                                   = "nic1"
      primary                                = true
      ip_configuration_name                  = "ipConf-01"
      subnet_id                              = ""
      load_balancer_backend_address_pool_ids = [""]
      version                                = "IPv4"
    }
    nic2 = {
      name                                   = "nic2"
      primary                                = false
      ip_configuration_name                  = "ipConf-02"
      subnet_id                              = ""
      load_balancer_backend_address_pool_ids = [""]
      version                                = "IPv4"
    }
  }

  ext_lb_network_interface = {
    nic1 = {
      name                                   = "nic1"
      primary                                = true
      ip_configuration_name                  = "ipConf-01"
      subnet_id                              = ""
      load_balancer_backend_address_pool_ids = [""]
      version                                = "IPv4"
    }
    nic2 = {
      name                                   = "nic2"
      primary                                = false
      ip_configuration_name                  = "ipConf-02"
      subnet_id                              = ""
      load_balancer_backend_address_pool_ids = [""]
      version                                = "IPv4"
    }
  }

  windows_source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  linux_source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  automatic_os_upgrade_policy = {
    disable_automatic_rollback  = true
    enable_automatic_os_upgrade = true
  }

  automatic_instance_repair = {
    enabled      = true
    grace_period = "PT10M"
    action       = "Reimage"
  }

  boot_diagnostics = {
    # Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics
    storage_account_uri = null
  }

  extension = {
    name                       = ""
    publisher                  = ""
    type                       = ""
    type_handler_version       = ""
    auto_upgrade_minor_version = ""
    settings                   = ""
    protected_settings         = ""
    provision_after_extensions = [""]
  }

  data_disk = {
  }

  identity = {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = []
  }

  # This is Required and can only be specified when upgrade_mode is set to Automatic or Rolling
  rolling_upgrade_policy = {
    max_batch_instance_percent              = 50
    max_unhealthy_instance_percent          = 100
    max_unhealthy_upgraded_instance_percent = 100
    pause_time_between_batches              = "PT5S"  # 5 seconds (PT10M signifies 10 minutes)
    maximum_surge_instances_enabled         = true   # Create new virtual machines to upgrade the scale set, rather than updating the existing virtual machines. overprovision must be set to false when maximum_surge_instances_enabled is specified.
  }

  scale_in = {
    rule                   = "Default"
    force_deletion_enabled = false
  }
}