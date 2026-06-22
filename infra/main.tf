data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

locals {
  common_tags = merge(var.tags, {
    environment  = var.environment
    "CostCenter" = var.cost_center
    "Department" = var.department
    "Created by" = "DevOps"
  })
}

data "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "app_gateway" {
  name                 = var.app_gateway_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "vm" {
  name                 = var.vm_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

module "acr" {
  source = "../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  tags                = local.common_tags
}

module "app_gateway" {
  source = "../modules/app_gateway"

  name                = var.app_gateway_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  subnet_id           = data.azurerm_subnet.app_gateway.id
  tags                = local.common_tags
}

module "aks" {
  source = "../modules/aks"

  cluster_name        = var.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version
  aks_subnet_id       = data.azurerm_subnet.aks.id

  system_node_pool_vm_size = var.system_node_pool_vm_size
  worker_node_pool_vm_size = var.worker_node_pool_vm_size

  pod_cidr       = var.pod_cidr
  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip

  app_gateway_id                = module.app_gateway.app_gateway_id
  app_gateway_resource_group_id = data.azurerm_resource_group.main.id
  acr_id                        = module.acr.acr_id

  tags = local.common_tags
}

# Jump box in the vm-subnet to reach the private AKS API server
module "jumpbox" {
  source = "../modules/jumpbox"

  name                = var.jumpbox_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  subnet_id           = data.azurerm_subnet.vm.id
  vm_size             = var.jumpbox_vm_size
  admin_username      = var.jumpbox_admin_username
  admin_password      = var.jumpbox_admin_password
  aks_cluster_id      = module.aks.cluster_id

  tags = local.common_tags
}
