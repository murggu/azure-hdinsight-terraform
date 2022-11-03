resource "azurerm_storage_account" "hdi_st" {
  name                     = "st${local.safe_prefix}${local.safe_postfix}"
  resource_group_name      = azurerm_resource_group.hdi_rg.name
  location                 = azurerm_resource_group.hdi_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = local.tags
}

resource "azurerm_storage_container" "hdi_st_container" {
  name                 = "default"
  storage_account_name = azurerm_storage_account.hdi_st.name
}