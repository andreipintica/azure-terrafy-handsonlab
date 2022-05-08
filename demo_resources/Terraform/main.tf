resource "azurerm_network_security_rule" "res-5" {
  access                      = "Allow"
  description                 = "ASC JIT Network Access rule created by an initiation request for policy 'default' of VM 'WIN'."
  destination_address_prefix  = "10.0.0.4"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "SecurityCenter-JITRule-1170687618-8C18BF8921F041989344B4F1E3A0C370"
  network_security_group_name = "WIN-nsg"
  priority                    = 100
  protocol                    = "*"
  resource_group_name         = "terraformtesting"
  source_address_prefix       = "xx.xx.xx.xxx"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-0,
  ]
}
resource "azurerm_subnet" "res-6" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "default"
  resource_group_name  = "terraformtesting"
  virtual_network_name = "terraformtesting-vnet"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
resource "azurerm_network_interface" "res-7" {
  location            = "westeurope"
  name                = "win548"
  resource_group_name = "terraformtesting"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxxxxxxxx/resourceGroups/terraformtesting/providers/Microsoft.Network/publicIPAddresses/WIN-ip"
    subnet_id                     = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxxxxxxxx/resourceGroups/terraformtesting/providers/Microsoft.Network/virtualNetworks/terraformtesting-vnet/subnets/default"
  }
  depends_on = [
    azurerm_public_ip.res-1,
    azurerm_subnet.res-6,
    azurerm_network_security_group.res-0,
  ]
}
resource "azurerm_resource_group" "res-8" {
  location = "westeurope"
  name     = "terraformtesting"
}
resource "azurerm_network_security_group" "res-0" {
  location            = "westeurope"
  name                = "WIN-nsg"
  resource_group_name = "terraformtesting"
  depends_on = [
    azurerm_resource_group.res-8,
  ]
}
resource "azurerm_public_ip" "res-1" {
  allocation_method   = "Dynamic"
  location            = "westeurope"
  name                = "WIN-ip"
  resource_group_name = "terraformtesting"
  depends_on = [
    azurerm_resource_group.res-8,
  ]
}
resource "azurerm_virtual_network" "res-2" {
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  name                = "terraformtesting-vnet"
  resource_group_name = "terraformtesting"
  depends_on = [
    azurerm_resource_group.res-8,
  ]
}
resource "azurerm_network_security_rule" "res-4" {
  access                      = "Deny"
  description                 = "ASC JIT Network Access rule for policy 'default' of VM 'WIN'."
  destination_address_prefix  = "10.0.0.4"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "SecurityCenter-JITRule_1170687618_62799A5740DE464DB71C4F619369BBAD"
  network_security_group_name = "WIN-nsg"
  priority                    = 4096
  protocol                    = "*"
  resource_group_name         = "terraformtesting"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-0,
  ]
}