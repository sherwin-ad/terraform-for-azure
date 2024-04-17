terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

variable "azregion" {
  type = string
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = var.azregion
}