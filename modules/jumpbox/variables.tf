variable "name" {
  description = "Name of the jump box VM"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to deploy into"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "ID of the VM subnet"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "aks_cluster_id" {
  description = "Resource ID of the AKS cluster to grant the VM identity access to"
  type        = string
  default     = null
}

variable "assign_aks_role" {
  description = "Whether to grant the VM identity the AKS Cluster User role on aks_cluster_id"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
