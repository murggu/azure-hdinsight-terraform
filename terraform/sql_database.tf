resource "azurerm_sql_server" "hdi_sql" {
  name                         = "sql-${local.basename}"
  resource_group_name          = azurerm_resource_group.hdi_rg.name
  location                     = azurerm_resource_group.hdi_rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "This1sNotSecure!"

  tags = local.tags
}

resource "azurerm_sql_database" "hdi_sqldb_metastore" {
  for_each                         = var.metastore_sku
  name                             = join("", ["sqldb", local.safe_prefix, local.safe_postfix, each.key])
  resource_group_name              = azurerm_resource_group.hdi_rg.name
  location                         = azurerm_resource_group.hdi_rg.location
  server_name                      = azurerm_sql_server.hdi_sql.name
  edition                          = "Standard"
  requested_service_objective_name = each.value

  tags = local.tags
}

resource "azurerm_sql_firewall_rule" "metastore_server_rule" {
  name                = "AllowAzureServices"
  resource_group_name = azurerm_resource_group.hdi_rg.name
  server_name         = azurerm_sql_server.hdi_sql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}