resource "azurerm_virtual_network" "hdi_vnet" {
  name                = "vnet-${local.basename}"
  location            = azurerm_resource_group.hdi_rg.location
  resource_group_name = azurerm_resource_group.hdi_rg.name
  address_space       = ["10.0.0.0/16"]

  tags = local.tags
}

resource "azurerm_subnet" "hdi_snet_default" {
  name                 = "vnet-${local.basename}-default"
  resource_group_name  = azurerm_resource_group.hdi_rg.name
  virtual_network_name = azurerm_virtual_network.hdi_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}