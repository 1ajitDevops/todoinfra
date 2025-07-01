resource "azurerm_resource_group" "resource" {
  name     = var.resource_group_name
  location = var.resource_location
}

resource "azurerm_resource_group" "resource1" {
  name     = var.resource_group_name1
  location = var.resource_location1
}