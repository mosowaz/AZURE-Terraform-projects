# VM Extension to install IIS on windows VMSS
resource "azurerm_virtual_machine_scale_set_extension" "windows_iis_install" {
  name                         = "Install-IIS"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.windows_vmss.id
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.10"
  auto_upgrade_minor_version   = true
  automatic_upgrade_enabled    = false

  settings = jsonencode({
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -Name Web-Server -IncludeManagementTools; Remove-Item 'C:\\inetpub\\wwwroot\\iisstart.htm'; Add-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value $('Hello World from ' + $env:computername); Start-Service W3SVC; Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False\""
  })
}

# VM Extension to install NGINX on Linux VMSS
resource "azurerm_virtual_machine_scale_set_extension" "linux_nginx_install" {
  name                         = "install-NGINX"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  auto_upgrade_minor_version   = true
  automatic_upgrade_enabled    = false

  settings = jsonencode({
    "script" = base64encode(<<-EOF
      #!/bin/bash
      # Update package list
      apt-get update

      # Install Nginx
      apt-get install -y nginx
     
      echo "Hello World from $(hostname)" > /var/www/html/index.html 

      # restart Nginx service
      systemctl restart nginx

      # Enable Nginx to start on boot
      systemctl enable nginx

      # Disable the firewall
      ufw disable 
    EOF
    )
  })
}
