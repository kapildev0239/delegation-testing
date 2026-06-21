terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.0, < 4.0" }
  }

  # Local backend for testing; swap to azurerm backend for shared/prod state.
  # backend "azurerm" {
  #   resource_group_name  = "BIMPAY-TF-STATE"
  #   storage_account_name = "bimpaytfstate"
  #   container_name       = "tfstate"
  #   key                  = "networking.tfstate"
  # }
}

provider "azurerm" {
  subscription_id = "4214fd24-e1dc-40be-a56d-da2a07fc058a"

  # Credentials injected via environment variables by GitHub Actions:
  #   ARM_CLIENT_ID     – parsed from ACR_CREDENTIALS secret
  #   ARM_CLIENT_SECRET – parsed from ACR_CREDENTIALS secret
  #   ARM_TENANT_ID     – parsed from ACR_CREDENTIALS secret

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
