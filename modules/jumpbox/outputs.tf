output "vm_id" {
  description = "Resource ID of the jump box VM"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_name" {
  description = "Name of the jump box VM"
  value       = azurerm_linux_virtual_machine.main.name
}

output "private_ip_address" {
  description = "Private IP address of the jump box"
  value       = azurerm_network_interface.main.private_ip_address
}

output "public_ip_address" {
  description = "Public IP address of the jump box"
  value       = azurerm_public_ip.main.ip_address
}

output "identity_principal_id" {
  description = "Principal ID of the VM system-assigned identity"
  value       = azurerm_linux_virtual_machine.main.identity[0].principal_id
}
