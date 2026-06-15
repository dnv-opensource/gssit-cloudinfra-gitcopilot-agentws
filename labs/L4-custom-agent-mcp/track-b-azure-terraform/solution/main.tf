terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.resource_group_name}-law"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "PerGB2018"
  retention_in_days   = var.workspace_retention_days
  tags                = var.tags
}

output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Use this in Step 4 when asking Azure MCP to list resources."
}

output "workspace_id" {
  value       = azurerm_log_analytics_workspace.main.id
  description = "Full ARM ID — Azure MCP needs this for KQL queries in Step 5."
}

output "workspace_name" {
  value       = azurerm_log_analytics_workspace.main.name
  description = "Short workspace name (handy for Azure MCP prompts)."
}
