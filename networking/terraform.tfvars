environment         = "dev"
project_name        = "bimpay"
location            = "eastus"
resource_group_name = "delegation-rg"

# VNet
vnet_name          = "bimpay-networking-vnet"
vnet_address_space = ["10.0.0.0/20"]

# AKS subnet – large block for node + pod IPs
aks_subnet_name             = "aks-subnet"
aks_subnet_address_prefixes = ["10.0.0.0/22"]

# VM subnet – jump boxes and runners
vm_subnet_name             = "vm-subnet"
vm_subnet_address_prefixes = ["10.0.4.0/24"]

# App Gateway subnet – Azure requires /24 minimum for App Gateway v2
app_gateway_subnet_name             = "appgw-subnet"
app_gateway_subnet_address_prefixes = ["10.0.5.0/24"]

cost_center = "BIMPAY"
department  = "FCBB DES"

tags = {
  project     = "bimpay"
  environment = "dev"
  "System"    = "BIMPAY"
}
