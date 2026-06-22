output "acr_id" {
  description = "Resource ID of the ACR"
  value       = azurerm_container_registry.main.id
}

output "acr_name" {
  description = "Name of the ACR"
  value       = azurerm_container_registry.main.name
}

output "login_server" {
  description = "Login server URL of the ACR"
  value       = azurerm_container_registry.main.login_server
}
