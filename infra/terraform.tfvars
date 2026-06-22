environment         = "dev"
project_name        = "delegation"
location            = "eastus"
resource_group_name = "delegation-rg"

# VNet reference – must match what networking/ deployed (same RG)
vnet_name               = "bimpay-networking-vnet"
aks_subnet_name         = "aks-subnet"
app_gateway_subnet_name = "appgw-subnet"

# ACR (alphanumeric only, globally unique)
acr_name = "delegationacr6478945"

# App Gateway
app_gateway_name = "delegation-appgw"

# AKS
aks_cluster_name         = "delegation-aks"
aks_dns_prefix           = "delegation-aks"
kubernetes_version       = "1.34.7"
system_node_pool_vm_size = "Standard_D2s_v3"
worker_node_pool_vm_size = "Standard_D2s_v3"

# Azure CNI overlay CIDRs (no overlap with VNet 10.0.0.0/20)
pod_cidr       = "192.168.0.0/16"
service_cidr   = "10.1.0.0/16"
dns_service_ip = "10.1.0.10"

cost_center = "DELEGATION"
department  = "FCBB DES"

tags = {
  project     = "delegation"
  environment = "dev"
}
