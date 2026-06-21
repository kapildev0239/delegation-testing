output "vnet_id" {
  description = "Resource ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "aks_subnet_id" {
  description = "Resource ID of the AKS subnet"
  value       = azurerm_subnet.aks.id
}

output "vm_subnet_id" {
  description = "Resource ID of the VM subnet"
  value       = azurerm_subnet.vm.id
}

output "app_gateway_subnet_id" {
  description = "Resource ID of the Application Gateway subnet"
  value       = azurerm_subnet.app_gateway.id
}
