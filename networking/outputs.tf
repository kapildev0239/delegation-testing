output "vnet_id" {
  description = "Resource ID of the virtual network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.vnet.vnet_name
}

output "aks_subnet_id" {
  description = "Resource ID of the AKS subnet"
  value       = module.vnet.aks_subnet_id
}

output "vm_subnet_id" {
  description = "Resource ID of the VM subnet"
  value       = module.vnet.vm_subnet_id
}

output "app_gateway_subnet_id" {
  description = "Resource ID of the Application Gateway subnet"
  value       = module.vnet.app_gateway_subnet_id
}
