resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_name
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_link" {
  name                  = var.private_dns_zone_link_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.rg_name
}

resource "azurerm_postgresql_flexible_server" "db_postgres" {
  name                   = var.db_postgres_name
  resource_group_name    = var.rg_name
  location               = var.rg_location
  version                = var.db_postgres_version
  delegated_subnet_id    = var.vnet_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
  administrator_login    = var.db_postgres_admin_user
  administrator_password = var.db_postgres_admin_pass
  zone                   = var.db_postgres_zone
  storage_mb             = var.db_postgres_storage_mb
  sku_name               = var.db_postgres_sku_name
  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.private_dns_zone_link
  ]

}
