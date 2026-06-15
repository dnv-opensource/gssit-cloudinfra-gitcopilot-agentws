variable "resource_group_name" {
  description = "Name of the resource group. Use rg-l4-<your-username>-<random> to stay unique inside the shared sandbox subscription."
  type        = string

  validation {
    condition     = can(regex("^rg-l4-[a-z0-9-]+$", var.resource_group_name))
    error_message = "Use the pattern rg-l4-<lowercase-username-or-initials>-<short-suffix>. Lowercase, digits, and hyphens only."
  }
}

variable "location" {
  description = "Azure region. Defaults to West Europe — change if your sandbox sub is regionally restricted."
  type        = string
  default     = "westeurope"
}

variable "workspace_retention_days" {
  description = "Log Analytics workspace retention in days. 30 is the minimum for the PerGB2018 SKU."
  type        = number
  default     = 30

  validation {
    condition     = var.workspace_retention_days >= 30 && var.workspace_retention_days <= 730
    error_message = "Retention must be between 30 and 730 days."
  }
}

variable "workspace_name" {
  description = "Name of the Log Analytics workspace. Must be 4-63 characters with letters, digits, or hyphens (no leading/trailing hyphens)."
  type        = string
  default     = "law-l4-workspace"

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{2,61}[a-zA-Z0-9]$", var.workspace_name)) || can(regex("^[a-zA-Z0-9]{4,63}$", var.workspace_name))
    error_message = "Workspace name must be 4-63 characters, start and end with alphanumeric, and contain only letters, digits, and hyphens."
  }
}

variable "tags" {
  description = "Tags applied to every resource. Defaults flag the lab + owner for sandbox-sub cost reports."
  type        = map(string)
  default = {
    workshop = "gssit-cloudinfra-gitcopilot-agentws"
    lab      = "L4-track-b"
  }
}
