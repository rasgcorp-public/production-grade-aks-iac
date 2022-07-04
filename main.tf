terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.99.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "terraform20220610"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source      = "./modules/rg"
  rg_name     = "poc-wso2-rg"
  rg_location = "eastus"
}

module "network" {
  source                   = "./modules/network"
  rg_name                  = module.rg.rg_name
  rg_location              = module.rg.rg_location
  vnet_name                = "poc-wso2-vnet"
  vnet_address_space       = "10.0.0.0/16"
  aks_subnet_name          = "aks-nodepool1-sn"
  aks_subnet_address_space = "10.0.0.0/24"
  db_subnet_name           = "postgresql-db-sn"
  db_subnet_address_space  = "10.0.1.0/24"

  depends_on = [
    module.rg
  ]
}

module "database_postgresql" {
  source      = "./modules/db-postgresql"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location

  private_dns_name           = "pocwso2.postgres.database.azure.com"
  private_dns_zone_link_name = "pocwso2"
  vnet_id                    = module.network.vnet_id
  db_postgres_name           = "poc-wso2-postgresql-db"
  db_postgres_version        = "13" # support 2025
  vnet_subnet_id             = module.network.subnet_db_id
  db_postgres_admin_user     = "psqladmin"
  db_postgres_admin_pass     = "@dm1N"
  db_postgres_zone           = "1"
  db_postgres_storage_mb     = "32768"
  db_postgres_sku_name       = "B_Standard_B1ms"

  depends_on = [
    module.network
  ]
}



# module "aks" {
#   source                    = "Azure/aks/azurerm"
#   version                   = "4.16.0"
#   resource_group_name       = module.rg.rg_name
#   prefix                    = "aks-wso2-prefix"
#   cluster_name              = "poc-wso2-aks"
#   network_plugin            = "kubenet"
#   vnet_subnet_id            = module.network.vnet_subnets[0]
#   os_disk_size_gb           = 50
#   sku_tier                  = "Free"
#   private_cluster_enabled   = false
#   enable_azure_policy       = true
#   enable_auto_scaling       = true
#   agents_min_count          = 1
#   agents_max_count          = 2
#   agents_count              = 1
#   agents_max_pods           = 100
#   agents_pool_name          = "wso2nodepool"
#   agents_availability_zones = ["1", "2"]
#   agents_type               = "VirtualMachineScaleSets"
#   agents_labels = {
#     "nodepool" : "defaultnodepool"
#   }

#   agents_tags = {
#     "Agent" : "defaultnodepoolagent"
#   }

#   enable_ingress_application_gateway = false

#   network_policy                 = "calico"
#   net_profile_service_cidr       = "10.0.1.0/24"
#   net_profile_dns_service_ip     = "10.0.1.10"
#   net_profile_docker_bridge_cidr = "170.10.0.1/16"

#   depends_on = [module.network]
# }
