terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.0, < 4.0" }
  }

  backend "azurerm" {
    resource_group_name  = "delegation-tfstate-rg"
    storage_account_name = "delegationtfstate"
    container_name       = "tfstate"
    key                  = "networking.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "4214fd24-e1dc-40be-a56d-da2a07fc058a"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
