terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.0, < 4.0" }
  }
}

provider "azurerm" {
  subscription_id = "4214fd24-e1dc-40be-a56d-da2a07fc058a"

  # Credentials injected via environment variables by GitHub Actions:
  #   ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID (parsed from ACR_CREDENTIALS)

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
