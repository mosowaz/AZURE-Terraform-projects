vmss = {
  linux_vmss_name   = "linux-vmss"
  windows_vmss_name = "windows-vmss"
  admin_username    = "adminuser"
  instances         = 4
  sku               = "Standard_F2s_v2"

  upgrade_mode                                      = "Rolling"
  do_not_run_extensions_on_overprovisioned_machines = true
  windows_enable_automatic_updates                  = false
  extension_operations_enabled                      = true
  provision_vm_agent                                = true
  windows_timezone                                  = "Eastern Standard Time"
  zones                                             = [1, 2, 3]
  health_probe_id                                   = ""

  int_lb_network_interface = {
    nic1 = {
      name                  = "nic1"
      primary               = true
      ip_configuration_name = "ipConf-01"
      subnet_id             = ""
      version               = "IPv4"
    }
    nic2 = {
      name                  = "nic2"
      primary               = false
      ip_configuration_name = "ipConf-02"
      subnet_id             = ""
      version               = "IPv4"
    }
  }

  ext_lb_network_interface = {
    nic1 = {
      name                  = "nic1"
      primary               = true
      ip_configuration_name = "ipConf-01"
      subnet_id             = ""
      version               = "IPv4"
    }
    nic2 = {
      name                  = "nic2"
      primary               = false
      ip_configuration_name = "ipConf-02"
      subnet_id             = ""
      version               = "IPv4"
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
    grace_period = "PT30M"
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

  scale_in = {
    rule                   = "Default"
    force_deletion_enabled = false
  }
}