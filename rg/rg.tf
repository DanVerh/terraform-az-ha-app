resource "azurerm_resource_group" "this" {
  count = var.is_rg_required ? 1 : 0
  
  name = var.rg_name
  location = var.rg_location[0]
}