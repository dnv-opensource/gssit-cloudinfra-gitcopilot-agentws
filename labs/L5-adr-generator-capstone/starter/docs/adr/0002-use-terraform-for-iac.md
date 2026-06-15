# 0002. Use Terraform for infrastructure as code

* Status: accepted
* Date: 2026-05-08

## Context

The Helios platform provisions Azure resources (resource groups, storage accounts, a
Container Apps environment, and Key Vault). Provisioning has so far been done by hand in
the portal, which is not reproducible and drifts between environments (dev / test / prod).

We evaluated the two infrastructure-as-code options in common use across our organisation:
Terraform and Bicep. Our standing preference is Terraform-first — it is the tooling our
cloud engineers use daily, it is multi-cloud, and it has a mature module ecosystem and
state/plan/drift workflow.

## Decision

We will use **Terraform** as the standard infrastructure-as-code tool for the Helios
platform. Bicep is not adopted. Each environment gets its own state, and infrastructure
changes go through `terraform plan` review before `terraform apply`.

## Consequences

* Infrastructure is reproducible and reviewable; drift is detectable via `terraform plan`.
* Engineers reuse skills and modules that already exist across other teams in the org.
* The team must manage Terraform state securely (remote backend) — a follow-up decision.
* Any future Azure-native-only feature that lacks a Terraform provider resource will need
  an `azapi` escape hatch rather than a switch to Bicep.
