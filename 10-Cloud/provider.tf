terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
  cloud {
    organization = "sherwinad-org"

    workspaces {
      name = "TerraformAzureCourse"
    }
  }
}

provider "azurerm" {
  features {
  }
}