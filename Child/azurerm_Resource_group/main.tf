resource "azurerm_resource_group" "resource" {
  name     = var.resource_group_name
  location = var.resource_location
}