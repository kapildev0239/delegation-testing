variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to deploy the AKS cluster into"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34.7"
}

variable "aks_subnet_id" {
  description = "Subnet ID for AKS nodes"
  type        = string
}

variable "system_node_pool_vm_size" {
  description = "VM size for the system node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "worker_node_pool_vm_size" {
  description = "VM size for the worker node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "pod_cidr" {
  description = "CIDR for pod IPs (Azure CNI overlay; must not overlap VNet address space)"
  type        = string
  default     = "192.168.0.0/16"
}

variable "service_cidr" {
  description = "CIDR for Kubernetes service IPs (must not overlap VNet or pod CIDR)"
  type        = string
  default     = "10.1.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address for the cluster DNS service (must be within service_cidr)"
  type        = string
  default     = "10.1.0.10"
}

variable "app_gateway_id" {
  description = "Resource ID of the Application Gateway for AGIC"
  type        = string
}

variable "app_gateway_resource_group_id" {
  description = "Resource ID of the resource group containing the App Gateway (for AGIC Contributor role)"
  type        = string
}

variable "acr_id" {
  description = "Resource ID of the ACR to grant AcrPull to AKS kubelet identity"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
