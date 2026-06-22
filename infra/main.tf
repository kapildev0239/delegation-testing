# Import the RG if it was created outside of this state (e.g. from a prior failed apply).
import {
  to = azurerm_resource_group.main
  id = "/subscriptions/4214fd24-e1dc-40be-a56d-da2a07fc058a/resourceGroups/delegation-infra-rg"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

locals {
  common_tags = merge(var.tags, {
    environment  = var.environment
    "CostCenter" = var.cost_center
    "Department" = var.department
    "Created by" = "DevOps"
  })
}

# Look up subnets provisioned by the networking/ deployment
data "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_subnet" "app_gateway" {
  name                 = var.app_gateway_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

module "acr" {
  source = "../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = local.common_tags
}

module "app_gateway" {
  source = "../modules/app_gateway"

  name                = var.app_gateway_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = data.azurerm_subnet.app_gateway.id
  tags                = local.common_tags
}

module "aks" {
  source = "../modules/aks"

  cluster_name        = var.aks_cluster_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version
  aks_subnet_id       = data.azurerm_subnet.aks.id

  system_node_pool_vm_size = var.system_node_pool_vm_size
  worker_node_pool_vm_size = var.worker_node_pool_vm_size

  pod_cidr       = var.pod_cidr
  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip

  app_gateway_id                = module.app_gateway.app_gateway_id
  app_gateway_resource_group_id = azurerm_resource_group.main.id
  acr_id                        = module.acr.acr_id

  tags = local.common_tags
}
