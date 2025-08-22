# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Disable firewall
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False

# # Open port 80 for incoming HTTP access
# New-NetFirewallRule -DisplayName "HTTP Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow

# # Open port 443 for incoming HTTPS access
# New-NetFirewallRule -DisplayName "HTTPS Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
