terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # TODO: pin a version. Ask Terraform MCP what the latest 4.x release is,
      # or look it up at https://registry.terraform.io/providers/hashicorp/azurerm/latest
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  # `subscription_id` is read from the AZURE_SUBSCRIPTION_ID env var or the
  # `az account show` selected subscription. Don't hardcode it here.
}

# ----------------------------------------------------------------------------
# TODO with Plan Mode + Terraform MCP:
#   Ask the agent to scaffold the two resources below. Use prompts like:
#
#     "Use Terraform MCP to look up the exact argument names for
#      azurerm_resource_group and azurerm_log_analytics_workspace,
#      then scaffold both. Resource group name should come from
#      var.resource_group_name, location from var.location, and the
#      workspace SKU should be PerGB2018 with a 30-day retention."
#
# Expected when you're done:
#   - resource "azurerm_resource_group" "main" {}
#   - resource "azurerm_log_analytics_workspace" "main" {}    (in main RG)
# ----------------------------------------------------------------------------

# resource "azurerm_resource_group" "main" {
#   ...
# }

# resource "azurerm_log_analytics_workspace" "main" {
#   ...
# }

# ----------------------------------------------------------------------------
# Outputs let you (and the agent) reference the deployed resources by name
# in Step 4. Uncomment once the resources above exist.
# ----------------------------------------------------------------------------

# output "resource_group_name" {
#   value = azurerm_resource_group.main.name
# }
#
# output "workspace_id" {
#   value = azurerm_log_analytics_workspace.main.id
# }
