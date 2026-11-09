terraform {
  required_version = ">= 1.16.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 5.0"
    }
  }
  # backend "prod-backend" {
  #   resource_group_name = ""
  #   storage_account_name = ""
  #   container_name = ""
  #   key = prod.tfstate
  # }
}

provider "azurerm" {
  features {}
}