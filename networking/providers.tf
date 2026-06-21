terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.0, < 4.0" }
  }

  backend "azurerm" {
    key            = "networking.tfstate"
    container_name = "tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
