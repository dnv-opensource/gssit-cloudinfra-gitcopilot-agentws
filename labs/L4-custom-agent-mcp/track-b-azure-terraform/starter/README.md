# Track B — starter

Skeleton Terraform module. **Intentionally incomplete** — the resource blocks are commented out so the agent has work to do in Step 2.

## Files

| File | Purpose |
|------|---------|
| `main.tf` | `terraform` block + `azurerm` provider + commented-out resource scaffolds with TODOs |
| `variables.tf` | RG name, location, retention, tags — already filled out so you don't burn time on inputs |
| `terraform.auto.tfvars.example` | Copy to `terraform.auto.tfvars` and personalize before Step 3. Terraform auto-loads any `*.auto.tfvars` file, so the rename is all that's needed — no `-var-file` flag. The shipped `REPLACEME` placeholder fails validation on purpose so you can't accidentally deploy a clashing RG name. |
| `.vscode/mcp.json` | Pre-wired Terraform MCP server entry (`stdio` → `C:\tools\terraform-mcp-server\terraform-mcp-server.exe`). Edit the `command` path if your binary lives elsewhere. |
| `images/` | Screenshots referenced from the track README |

## Don't edit before Step 2

The point of Step 2 is to let Plan Mode + Terraform MCP fill the resource blocks for you. If you author them by hand you skip the lesson.

## Files Terraform will create at apply time

These land in this folder during `terraform init` / `terraform apply` and are **gitignored** repo-wide — do not commit them:

- `.terraform/` (provider cache)
- `.terraform.lock.hcl`
- `terraform.tfstate` / `terraform.tfstate.backup`
- `terraform.tfvars` (if you create one for your RG name)

Run `terraform destroy` before you leave the slot — the state file references real resources in the shared sub.
