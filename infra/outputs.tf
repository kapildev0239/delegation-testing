# output "resource_group_name" {
#   description = "Resource group name"
#   value       = azurerm_resource_group.main.name
# }

output "acr_login_server" {
  description = "ACR login server URL"
  value       = module.acr.login_server
}

output "app_gateway_private_ip" {
  description = "Private frontend IP of the App Gateway (point sample.delegation.net A record here)"
  value       = module.app_gateway.private_ip_address
}

output "app_dns_zone_name" {
  description = "Private DNS zone name for app hostnames"
  value       = azurerm_private_dns_zone.app.name
}

output "app_gateway_public_ip" {
  description = "Public IP of the Application Gateway"
  value       = module.app_gateway.public_ip_address
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}

output "aks_oidc_issuer_url" {
  description = "OIDC issuer URL (for workload identity federation)"
  value       = module.aks.oidc_issuer_url
}

output "jumpbox_private_ip" {
  description = "Private IP of the jump box VM"
  value       = module.jumpbox.private_ip_address
}

output "jumpbox_public_ip" {
  description = "Public IP of the jump box VM (SSH: ssh azureuser@<this-ip>)"
  value       = module.jumpbox.public_ip_address
}
