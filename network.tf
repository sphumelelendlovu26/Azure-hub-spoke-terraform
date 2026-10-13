resource "azurerm_virtual_network" "hub_vnet" {
  name                = "HUB-Vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.az700-terraform-rg.name
  address_space       = [var.hub_cidr]
}
resource "azurerm_virtual_network" "spoke" {
  for_each            = var.spokes
  name                = each.value.spoke_name
  location            = var.location
  resource_group_name = azurerm_resource_group.az700-terraform-rg.name
  address_space       = [each.value.spoke_cidr]
}

resource "azurerm_subnet" "spoke_subnet" {
  for_each             = local.subnet
  name                 = each.value.subnet_name
  address_prefixes     = each.value.subnet_cidr
  virtual_network_name = azurerm_virtual_network.spoke[each.key].name
  resource_group_name  = azurerm_resource_group.az700-terraform-rg.name
}

resource "azurerm_subnet" "hub_subnet" {
  for_each             = var.hub_subnets
  name                 = each.value.subnet_name
  address_prefixes     = [each.value.subnet_cidr]
  resource_group_name  = azurerm_resource_group.az700-terraform-rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
}