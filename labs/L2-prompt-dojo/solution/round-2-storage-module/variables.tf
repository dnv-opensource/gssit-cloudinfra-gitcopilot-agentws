variable "storage_account_name" {
  description = "Azure Storage account name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3-24 characters and use lowercase letters or numbers only."
  }
}

variable "resource_group_name" {
  description = "Target Azure resource group name."
  type        = string
}

variable "location" {
  description = "Azure region for the storage account."
  type        = string
}

variable "sku_name" {
  description = "Storage replication SKU."
  type        = string
  default     = "Standard_LRS"

  validation {
    condition     = contains(["Standard_LRS", "Standard_GRS", "Standard_ZRS"], var.sku_name)
    error_message = "sku_name must be one of: Standard_LRS, Standard_GRS, Standard_ZRS."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = false
}
