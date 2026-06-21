variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "Name of the AKS subnet"
  type        = string
  default     = "aks-subnet"
}

variable "aks_subnet_address_prefixes" {
  description = "Address prefixes for the AKS subnet"
  type        = list(string)
}

variable "vm_subnet_name" {
  description = "Name of the VM subnet"
  type        = string
  default     = "vm-subnet"
}

variable "vm_subnet_address_prefixes" {
  description = "Address prefixes for the VM subnet"
  type        = list(string)
}

variable "app_gateway_subnet_name" {
  description = "Name of the Application Gateway subnet"
  type        = string
  default     = "appgw-subnet"
}

variable "app_gateway_subnet_address_prefixes" {
  description = "Address prefixes for the Application Gateway subnet"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
