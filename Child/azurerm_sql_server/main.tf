resource "azurerm_mssql_server" "mssql-server" {
  name                         = var.mssql-server-name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.mssql-version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}
