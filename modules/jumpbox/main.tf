resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    # No public IP: private-only jump box. Reach it via Bastion or VPN.
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.main.id]
  tags                            = var.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # cloud-init: install Azure CLI and kubectl so the box can reach private AKS
  custom_data = base64encode(<<-CLOUDINIT
    #cloud-config
    package_update: true
    runcmd:
      - curl -sL https://aka.ms/InstallAzureCLIDeb | bash
      - az aks install-cli
    CLOUDINIT
  )

  # Managed identity so it can run `az aks get-credentials` without stored creds
  identity {
    type = "SystemAssigned"
  }
}

# Allow the jump box identity to pull AKS admin/user credentials and reach the cluster
resource "azurerm_role_assignment" "aks_user" {
  count                = var.aks_cluster_id != null ? 1 : 0
  principal_id         = azurerm_linux_virtual_machine.main.identity[0].principal_id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  scope                = var.aks_cluster_id
}
