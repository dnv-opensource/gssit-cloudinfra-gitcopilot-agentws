variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string

  validation {
    condition = (
      length(var.resource_group_name) >= 1 &&
      length(var.resource_group_name) <= 90 &&
      can(regex("^[0-9A-Za-z._-]+$", var.resource_group_name)) &&
      !endswith(var.resource_group_name, ".")
    )

    error_message = "Invalid resource_group_name '${var.resource_group_name}'. Use 1-90 characters, only letters, numbers, periods, underscores, or hyphens, and do not end with a period."
  }
}
