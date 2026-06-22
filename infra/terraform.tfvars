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

# Classic Azure CNI: pods get routable IPs from aks-subnet.
# service_cidr is virtual (not in the VNet) and must not overlap VNet/subnets.
service_cidr   = "10.1.0.0/16"
dns_service_ip = "10.1.0.10"

# Jump box (username/password auth)
jumpbox_name           = "delegation-jumpbox"
jumpbox_vm_size        = "Standard_D2s_v3"
jumpbox_admin_username = "azureuser"
jumpbox_admin_password = "Yellowandblack@26"

cost_center = "DELEGATION"
department  = "FCBB DES"

tags = {
  project     = "delegation"
  environment = "dev"
}
