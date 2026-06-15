# Azure Storage module with security-aware defaults.
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = split("_", var.sku_name)[0]
  account_replication_type = split("_", var.sku_name)[1]
  account_kind             = "StorageV2"

  public_network_access_enabled = var.public_network_access_enabled
  min_tls_version               = "TLS1_2"
}
