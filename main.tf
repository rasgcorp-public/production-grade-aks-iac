terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.10.0"
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
  source = "./modules/rg"
  rg_name = var.rg_name
  rg_location = var.location
}