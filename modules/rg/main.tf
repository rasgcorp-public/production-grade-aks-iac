resource "azurerm_resource_group" "poc_wso2_rg" {
  name     = var.rg_name
  location = var.rg_location
}