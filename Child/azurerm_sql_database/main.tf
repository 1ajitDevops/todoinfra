
resource "azurerm_mssql_database" "sql-database-name" {
  name         = var.sqldatabase-name
  server_id    = "/subscriptions/6f89d107-0df7-4bf9-9a60-43a792310639/resourceGroups/RG-1/providers/Microsoft.Sql/servers/tondu-server"
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}