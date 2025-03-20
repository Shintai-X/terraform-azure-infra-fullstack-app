resource "azurerm_mssql_server" "mssql-server-app" {
  name                         = "mssql-server-app"
  resource_group_name          = var.rg_name 
  location                     = var.rg_location 
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "mssql-database" {
  name         = "mssql-database"
  server_id    = azurerm_mssql_server.mssql-server-app.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_mssql_virtual_network_rule" "mssql_vnet_rule" {
  name      = "sql-vnet-rule"
  server_id = azurerm_mssql_server.mssql-server-app.id
  subnet_id = var.subnet_db_id
}