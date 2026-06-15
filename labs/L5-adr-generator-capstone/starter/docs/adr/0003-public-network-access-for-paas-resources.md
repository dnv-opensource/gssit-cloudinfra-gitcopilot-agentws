---
title: "ADR-0003: Use Public Network Access for PaaS Resources"
status: "Proposed"
date: "2026-06-14"
authors: "Helios Platform Team"
tags: ["architecture", "decision", "networking", "security", "terraform"]
supersedes: ""
superseded_by: ""
---

# ADR-0003: Use Public Network Access for PaaS Resources

## Status

**Proposed**

## Context

The Terraform in [terraform/main.tf](../../terraform/main.tf) explicitly enables public network access for the storage account and SQL server, and the file contains no `azurerm_private_endpoint`, `azurerm_virtual_network`, or `azurerm_log_analytics_workspace` resources.

This means the current sample workload is intentionally reachable over the public internet rather than being isolated behind private networking. The code also contains a note that diagnostic settings and Log Analytics were not added, which reinforces that this stack is intentionally minimal and not yet hardened for a private enterprise network posture.

## Decision

We will keep the sample workload on public network access for its Azure PaaS resources and will not add private endpoints or VNet-based isolation in this repository.

This applies to the storage account and SQL server currently defined in [terraform/main.tf](../../terraform/main.tf), and it matches the rest of the sample's lightweight, demo-oriented infrastructure posture.

## Consequences

### Positive

- **POS-001**: The stack stays simple to understand, provision, and debug because there is no VNet, private DNS, or endpoint plumbing to maintain.
- **POS-002**: The sample remains easy to run in a fresh environment without additional network dependencies or subnet planning.
- **POS-003**: The Terraform stays focused on the core IaC concepts the lab is meant to teach instead of expanding into network architecture.

### Negative

- **NEG-001**: The workload is less secure than a private-only deployment because the resources remain reachable over public endpoints.
- **NEG-002**: This posture would not satisfy stricter enterprise controls that require private connectivity for data services.
- **NEG-003**: If the sample is later promoted toward production, a follow-up ADR will be needed to redesign network access, DNS, and possibly identity boundaries.

## Alternatives Considered

### Private endpoints and VNet isolation

- **ALT-001**: **Description**: Place the storage account and SQL server behind private endpoints, add a virtual network, and resolve service traffic through private DNS.
- **ALT-002**: **Rejection Reason**: This adds substantial infrastructure and operational complexity that is unnecessary for the current sample workload and would obscure the core IaC lesson.

### Hybrid posture with selective private connectivity

- **ALT-003**: **Description**: Keep the app publicly reachable but move only data services to private endpoints.
- **ALT-004**: **Rejection Reason**: This still introduces network and DNS complexity while leaving the overall sample only partially hardened; the codebase currently opts for a cleaner all-public baseline.

## Implementation Notes

- **IMP-001**: Keep `public_network_access_enabled = true` for the affected resources unless a future ADR explicitly replaces this decision.
- **IMP-002**: If the repository is ever hardened for production, introduce a new ADR that covers private endpoints, subnet design, private DNS, and any required firewall rules as a single change set.
- **IMP-003**: Use this ADR as the reference point when deciding whether to add observability resources, since network-hardening and telemetry hardening are separate decisions.

## References

- **REF-001**: [ADR-0001: Record architecture decisions](0001-record-architecture-decisions.md)
- **REF-002**: [ADR-0002: Use Terraform for infrastructure as code](0002-use-terraform-for-iac.md)
- **REF-003**: [terraform/main.tf](../../terraform/main.tf)