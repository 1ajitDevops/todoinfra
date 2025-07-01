resource "azurerm_public_ip" "public_IP" {
  name                = var.public_IP_name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  allocation_method   = var.allocation_method

}