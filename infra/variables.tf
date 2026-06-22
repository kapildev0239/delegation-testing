variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for all infra resources"
  type        = string
}

# Networking (must match values used in the networking deployment)
variable "vnet_name" {
  description = "Name of the existing VNet (deployed via networking/)"
  type        = string
}

variable "vnet_resource_group_name" {
  description = "Resource group that holds the VNet (may differ from infra RG)"
  type        = string
}

variable "aks_subnet_name" {
  description = "Name of the AKS subnet inside the VNet"
  type        = string
  default     = "aks-subnet"
}

variable "app_gateway_subnet_name" {
  description = "Name of the App Gateway subnet inside the VNet"
  type        = string
  default     = "appgw-subnet"
}

# ACR
variable "acr_name" {
  description = "Name of the Azure Container Registry (alphanumeric, globally unique)"
  type        = string
}

# App Gateway
variable "app_gateway_name" {
  description = "Name of the Application Gateway"
  type        = string
}

# AKS
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34.7"
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
  description = "Pod CIDR for Azure CNI overlay (must not overlap VNet)"
  type        = string
  default     = "192.168.0.0/16"
}

variable "service_cidr" {
  description = "Kubernetes service CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "dns_service_ip" {
  description = "Cluster DNS service IP (within service_cidr)"
  type        = string
  default     = "10.1.0.10"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "cost_center" {
  description = "Cost center tag value"
  type        = string
  default     = ""
}

variable "department" {
  description = "Department tag value"
  type        = string
  default     = ""
}
