resource "azurerm_kubernetes_cluster" "main" {
  name                      = var.cluster_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.dns_prefix
  kubernetes_version        = var.kubernetes_version
  private_cluster_enabled   = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name                        = "system"
    node_count                  = 1
    vm_size                     = var.system_node_pool_vm_size
    vnet_subnet_id              = var.aks_subnet_id
    only_critical_addons_enabled = true
    os_disk_size_gb             = 128
    type                        = "VirtualMachineScaleSets"

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # Classic Azure CNI: pods get real, routable VNet IPs from the node subnet
  # (aks-subnet). Required so AGIC / App Gateway can reach pod IPs directly.
  network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  identity {
    type = "SystemAssigned"
  }

  ingress_application_gateway {
    gateway_id = var.app_gateway_id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "worker" {
  name                  = "worker"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = var.worker_node_pool_vm_size
  node_count            = 1
  vnet_subnet_id        = var.aks_subnet_id
  os_disk_size_gb       = 128
  mode                  = "User"

  upgrade_settings {
    max_surge = "10%"
  }

  tags = var.tags
}

# Grant AKS kubelet identity AcrPull on the container registry
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}

# Grant AGIC identity Contributor on the App Gateway resource group
resource "azurerm_role_assignment" "agic_contributor" {
  principal_id         = azurerm_kubernetes_cluster.main.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
  role_definition_name = "Contributor"
  scope                = var.app_gateway_resource_group_id
}
