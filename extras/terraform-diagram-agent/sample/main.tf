###############################################################################
# Sample Terraform for the "Terraform → draw.io" diagram agent
#
# Small but deliberately multi-tier so the diagram has something to show:
#   - 1 resource group (container)
#   - networking: VNet + 2 subnets + NSG
#   - compute: 1 Linux App Service plan + web app
#   - data: 1 Storage Account
#   - security: 1 Key Vault + 1 user-assigned Managed Identity
#   - observability: Log Analytics workspace + Application Insights
#   - 1 explicit depends_on edge (web app -> key vault) to exercise that style
#   - 1 data source (current Azure config) to exercise that style
#
# This file is NOT meant to be `terraform apply`'d — it's a diagram fixture.
# Do not put real secrets, subscription IDs, or tenant IDs here.
###############################################################################

terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

locals {
  prefix   = "diagdemo"
  location = "westeurope"
  tags = {
    workshop = "ai-coding"
    purpose  = "diagram-fixture"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.prefix}"
  location = local.location
  tags     = local.tags
}

# ---------- Networking --------------------------------------------------------

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${local.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.20.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.20.1.0/24"]
}

resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.20.2.0/24"]
}

resource "azurerm_network_security_group" "app" {
  name                = "nsg-app"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags
}

# ---------- Identity ----------------------------------------------------------

resource "azurerm_user_assigned_identity" "app" {
  name                = "id-${local.prefix}-app"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags
}

# ---------- Security ----------------------------------------------------------

resource "azurerm_key_vault" "this" {
  name                = "kv-${local.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = local.tags
}

# ---------- Data --------------------------------------------------------------

resource "azurerm_storage_account" "this" {
  name                     = "st${local.prefix}data"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}

# ---------- Compute -----------------------------------------------------------

resource "azurerm_service_plan" "this" {
  name                = "plan-${local.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = local.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${local.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.this.id
  tags                = local.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app.id]
  }

  site_config {}

  # Explicit dependency so the diagram agent exercises the depends_on style.
  depends_on = [azurerm_key_vault.this]
}

# ---------- Observability -----------------------------------------------------

resource "azurerm_log_analytics_workspace" "this" {
  name                = "law-${local.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

resource "azurerm_application_insights" "this" {
  name                = "appi-${local.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
  tags                = local.tags
}
