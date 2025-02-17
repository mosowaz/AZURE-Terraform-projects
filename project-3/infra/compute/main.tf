resource "azurerm_resource_group" "rg" {
  name     = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
}

# Bastion Host
module "azure_bastion" {
  source = "Azure/avm-res-network-bastionhost/azurerm"

  enable_telemetry    = true
  name                = "BastionHost-SEP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  copy_paste_enabled  = true
  file_copy_enabled   = false
  sku                 = "Standard"
  ip_configuration = {
    name                 = "my-ipconfig"
    subnet_id            = data.azurerm_subnet.BastionSubnet.id
    public_ip_address_id = data.azurerm_public_ip.pub_ip.id
  }
  ip_connect_enabled     = true
  scale_units            = 4
  shareable_link_enabled = true
  tunneling_enabled      = true
  kerberos_enabled       = true
  depends_on = [azurerm_resource_group.rg]
}