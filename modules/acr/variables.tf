variable "acr_name" {
  description = "Name of the Azure Container Registry (alphanumeric, 5-50 chars, globally unique)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to deploy the ACR into"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
