# Round 2 — Target prompt

## Target specific prompt

```text
Create a Terraform module for Azure Storage with:

Required inputs:
- storage_account_name (3-24 chars, lowercase alphanumeric only)
- resource_group_name
- location

Optional inputs with defaults:
- sku_name (default: "Standard_LRS", allowed: Standard_LRS, Standard_GRS, Standard_ZRS)
- public_network_access_enabled (default: false)

Outputs:
- storage_account_id
- primary_blob_endpoint

Include:
- A brief description comment at the top
- Use Terraform 1.5+ syntax
```

## Sample-shape Copilot output

A strong answer usually has this structure:

```hcl
# Azure Storage module with security-aware defaults.
terraform {
  required_version = ">= 1.5.0"
}

variable "storage_account_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "Standard_LRS"
}

resource "azurerm_storage_account" "this" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  public_network_access_enabled = var.public_network_access_enabled
}

output "storage_account_id" {
  value = azurerm_storage_account.this.id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}
```

See `round-2-storage-module\` for a parseable module example.

## Self-check rubric

- All required inputs exist as Terraform variables
- Optional inputs have defaults and allowed-value validation where relevant
- The resource is `azurerm_storage_account`, not another cloud guess
- Both requested outputs are present

## What context shifted

The important change is **contract + target platform + version**. By naming the inputs, defaults, outputs, cloud, and syntax target, you stop Copilot from guessing and force it to draft the module you actually wanted.
