resource "azurerm_firewall" "hub_firewall" {
  name                = "Hub-Firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.az700-terraform-rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id
  ip_configuration {
    name                 = "Firewall-Public-IP"
    subnet_id            = azurerm_subnet.hub_subnet["firewall"].id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = "Firewall_Policy"
  location            = var.location
  resource_group_name = azurerm_resource_group.az700-terraform-rg.name
}
resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_collection" {
  name               = "Firewall_Policy_Collection"
  priority           = 100
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "Firewall_Public_IP"
  allocation_method   = "Static"
  resource_group_name = azurerm_resource_group.az700-terraform-rg.name
  location            = var.location
  sku                 = "Standard"
  sku_tier            = "Regional"
}
