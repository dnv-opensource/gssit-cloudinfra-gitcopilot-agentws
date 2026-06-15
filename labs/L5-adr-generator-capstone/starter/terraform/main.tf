###############################################################################
# Helios platform — fictional sample workload for L5 capstone.
#
# This file deliberately contains a handful of architectural decisions that
# WERE NEVER WRITTEN DOWN. Your ADR Architect agent's job is to find one and
# document it.
#
# Hints (don't peek if you want the agent to find them on its own):
#   - Single region only — no paired-region failover.
#   - Storage account replication is LRS (locally redundant).
#   - SQL Database is on the General Purpose serverless tier, public network ON.
#   - App Service plan is B1 (Basic) — fine for dev, not for prod scale.
#   - No private endpoints anywhere — everything talks over the public internet.
#   - No diagnostic settings / Log Analytics — telemetry decision was skipped.
###############################################################################

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

variable "workload" {
  type    = string
  default = "helios"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "swedencentral"
}

locals {
  prefix = "${var.workload}-${var.environment}"

  common_tags = {
    workload    = var.workload
    environment = var.environment
    managed-by  = "terraform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.prefix}-001"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "this" {
  name                     = "st${var.workload}${var.environment}001"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # decision: durability tier — never documented
  min_tls_version          = "TLS1_2"
  public_network_access_enabled = true # decision: public access — never documented
  tags                     = local.common_tags
}

resource "azurerm_service_plan" "this" {
  name                = "asp-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B1" # decision: SKU sizing — never documented
  tags                = local.common_tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.this.id
  tags                = local.common_tags

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }
}

resource "azurerm_mssql_server" "this" {
  name                         = "sql-${local.prefix}-001"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = "heliosadmin"
  administrator_login_password = "ChangeMe-In-Pipeline-Not-Here!"
  public_network_access_enabled = true # decision: public access — never documented
  tags                         = local.common_tags
}

resource "azurerm_mssql_database" "this" {
  name      = "sqldb-${local.prefix}-001"
  server_id = azurerm_mssql_server.this.id
  sku_name  = "GP_S_Gen5_2" # decision: serverless General Purpose — never documented
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5
  max_size_gb                 = 32
  tags                        = local.common_tags
}

# NOTE: no azurerm_log_analytics_workspace, no diagnostic_setting resources.
# Telemetry/observability is an undocumented decision in its own right.
