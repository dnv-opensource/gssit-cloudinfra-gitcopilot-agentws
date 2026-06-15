# Round 1 — Target prompt

## Target specific prompt

```text
Add validation to this Terraform variable for an Azure resource group name:

variable "resource_group_name" {
  type = string
}

Validation rules:
1. Length must be 1-90 characters
2. Can only contain alphanumerics, hyphens, underscores, and periods
3. Cannot end with a period
4. Error message should show the invalid value and explain the constraint
```

## Sample-shape Copilot output

A strong answer usually looks like this shape:

```hcl
variable "resource_group_name" {
  type = string

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
```

See `round-1-validation-example.tf` for a parseable version.

## Self-check rubric

- `validation` block exists inside the variable
- `condition` checks length and allowed characters
- `error_message` references `var.resource_group_name`

## What context shifted

The important change is **schema + explicit rules**. Once Copilot can see the exact variable and the exact constraints, it stops inventing a generic validation stub and starts drafting a usable one.
