terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
  /* backend "local" {
    path = "./secret/terraform.tfstate" 
  } */
  backend "azurerm" {
    resource_group_name = "mytfstateorg"
    storage_account_name = "mytfstatesa"
    container_name = "mytfstatecon"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}