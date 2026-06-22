import {
  to = azurerm_resource_group.main
  id = "/subscriptions/4214fd24-e1dc-40be-a56d-da2a07fc058a/resourceGroups/delegation-rg"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

locals {
  location = var.location
  common_tags = merge(var.tags, {
    environment  = var.environment
    "CostCenter" = var.cost_center
    "Department" = var.department
    "Created by" = "DevOps"
  })
}

module "vnet" {
  source = "../modules/vnet"

  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_space
  tags                = local.common_tags

  aks_subnet_name             = var.aks_subnet_name
  aks_subnet_address_prefixes = var.aks_subnet_address_prefixes

  vm_subnet_name             = var.vm_subnet_name
  vm_subnet_address_prefixes = var.vm_subnet_address_prefixes

  app_gateway_subnet_name             = var.app_gateway_subnet_name
  app_gateway_subnet_address_prefixes = var.app_gateway_subnet_address_prefixes
}
