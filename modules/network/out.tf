output "vnet_id" {
  value = azurerm_virtual_network.poc_wso2_vnet.id
}

output "subnet_aks_id" {
  value = azurerm_subnet.aks_subnet.id
}

output "subnet_db_id" {
  value = azurerm_subnet.db_subnet.id
}
