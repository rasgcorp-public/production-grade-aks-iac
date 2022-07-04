variable "private_dns_name" {
  type = string
}
variable "rg_name" {
  type = string
}
variable "rg_location" {
  type = string
}
variable "private_dns_zone_link_name" {
  type = string
}
variable "vnet_id" {
  type = string
}
variable "db_postgres_name" {
  type = string
}
variable "db_postgres_version" {
  type = string
}

variable "vnet_subnet_id" {
  type = string
}
variable "db_postgres_admin_user" {
  type = string
}
variable "db_postgres_admin_pass" {
  type = string
}
variable "db_postgres_zone" {
  type = string
}
variable "db_postgres_storage_mb" {
  type = string
}
variable "db_postgres_sku_name" {
  type = string
}
