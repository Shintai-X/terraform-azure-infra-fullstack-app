resource "azurerm_resource_group" "rg-fullstack-app" {
  name     = var.rg_name
  location = var.rg_location
}