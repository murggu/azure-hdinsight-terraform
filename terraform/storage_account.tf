resource "azurerm_storage_account" "hdi_st" {
  name                     = "st${local.safe_prefix}${local.safe_postfix}"
  resource_group_name      = azurerm_resource_group.hdi_rg.name
  location                 = azurerm_resource_group.hdi_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  is_hns_enabled = var.enable_adls2 ? true : false

  tags = local.tags
}

resource "azurerm_storage_container" "hdi_st_container" {
  name                 = "default"
  storage_account_name = azurerm_storage_account.hdi_st.name

  count = var.enable_adls2 ? 0 : 1
}

resource "azurerm_role_assignment" "hdi_st_role_admin_sbdc" {
  scope                = azurerm_storage_account.hdi_st.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "hdi_st_role_id_sbdc" {
  scope                = azurerm_storage_account.hdi_st.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_user_assigned_identity.hdi_id.principal_id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "hdi_ws_adls" {
  name               = "default"
  storage_account_id = azurerm_storage_account.hdi_st.id

  depends_on = [
    azurerm_role_assignment.hdi_st_role_admin_sbdc
  ]

  count = var.enable_adls2 ? 1 : 0
}