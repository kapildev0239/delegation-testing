terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.0, < 4.0" }
  }
  # Intentionally local — this is a one-time bootstrap; state is trivial to recreate.
}

provider "azurerm" {
  subscription_id = "4214fd24-e1dc-40be-a56d-da2a07fc058a"
  features {}
}
