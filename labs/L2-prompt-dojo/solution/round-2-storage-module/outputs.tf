output "storage_account_id" {
  description = "Storage account resource ID."
  value       = azurerm_storage_account.this.id
}

output "primary_blob_endpoint" {
  description = "Primary Blob endpoint URL."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
