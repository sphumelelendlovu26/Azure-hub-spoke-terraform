resource "azurerm_resource_group" "az700-terraform-rg" {
  name     = "AZ700-Terraform-RG"
  location = var.location
}