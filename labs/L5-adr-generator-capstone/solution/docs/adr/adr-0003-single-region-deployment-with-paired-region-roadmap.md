---
title: "ADR-0003: Single-region deployment with paired-region failover roadmap"
status: "Proposed"
date: "2026-06-14"
authors: "ADR Architect (agent) · platform team"
tags: ["architecture", "decision", "reliability", "region", "azure"]
supersedes: ""
superseded_by: ""
waf_pillar: "Reliability"
cost_owner: "platform-team"
---

# ADR-0003: Single-region deployment with paired-region failover roadmap

## Status

**Proposed** | Accepted | Rejected | Superseded | Deprecated

## Context

The Helios sample workload is currently provisioned into a single Azure region — `swedencentral` — across resource group `rg-helios-dev-001`. Evidence from `terraform/main.tf`:

- `variable "location"` defaults to `swedencentral` (single value, no list).
- `azurerm_resource_group.this`, `azurerm_storage_account.this`, `azurerm_service_plan.this`, `azurerm_linux_web_app.this`, and `azurerm_mssql_server.this` are all created in that single region.
- `azurerm_storage_account.this.account_replication_type = "LRS"` (locally redundant — single datacenter).
- No `azurerm_traffic_manager_profile`, `azurerm_front_door_*`, no secondary `azurerm_mssql_server` failover group.

This is a deliberate cost / simplicity choice for `dev`, but it has never been written down. The same pattern is on track to be promoted to `prod` unchallenged.

## Decision

We will **explicitly accept** a single-region deployment in `swedencentral` for the `dev` environment, and **commit to a paired-region failover roadmap for `prod`** (target: `swedencentral` primary + `northeurope` secondary) before `prod` is provisioned.

This decision primarily serves the **Reliability** WAF pillar — by surfacing the gap and binding the team to a follow-up rather than letting the single-region default leak silently into `prod`.

## Consequences

### Positive

- **POS-001**: `dev` keeps current cost / complexity profile — no immediate spend increase.
- **POS-002**: A standing requirement to ADR `prod` topology *before* provisioning forces a reliability conversation early, not during the first incident.
- **POS-003**: Clear precedent for treating "what we did by default in dev" as a decision worth recording.

### Negative

- **NEG-001**: Until the `prod` ADR lands, the team has an explicit known gap — a regional Azure incident in `swedencentral` would take Helios `dev` offline with no failover.
- **NEG-002**: Storage uses LRS — even within `swedencentral`, a single-datacenter event can lose data. A follow-up ADR should evaluate ZRS for `prod`. *(NEG-001 from the next ADR.)*
- **NEG-003**: Estimated monthly cost delta to add paired-region for `prod`: **+$/mo ~40–80%** of current `prod` baseline (rough — App Service + SQL geo-replication + Front Door). Real number to land in the `prod`-topology ADR.

## Alternatives Considered

### Multi-region active-active from day one

- **ALT-001**: **Description**: Deploy Helios into two paired regions (`swedencentral` + `northeurope`) with Front Door / Traffic Manager fronting them, geo-replicated SQL, GZRS storage.
- **ALT-002**: **Rejection Reason**: Overkill for `dev`. Doubles infra cost (~+100%) and operational surface for an environment that has no real users. Defers the right conversation by hiding it behind unnecessary complexity.

### Single-region forever (do nothing, no follow-up)

- **ALT-003**: **Description**: Accept single-region indefinitely for both `dev` and `prod`. Treat the LRS / single-region posture as a permanent choice.
- **ALT-004**: **Rejection Reason**: Fails Reliability for `prod`. A regional Azure incident is a foreseeable event — leaving `prod` with no documented failover plan is operational debt, not a decision.

## Implementation Notes

- **IMP-001**: Add a `regions` variable to `terraform/variables.tf` (list type, default `[ "swedencentral" ]`) so the topology can be expressed declaratively when we add the second region.
- **IMP-002**: Block `prod` provisioning at the pipeline level until ADR-0004 ("`prod` regional topology") is `Accepted`. Pipeline gate is a label check on the PR that introduces `environment = "prod"`.
- **IMP-003**: Add a synthetic uptime probe (Application Insights availability test) once the workload is published — current monitoring gap means we wouldn't know about an outage anyway. Track this as ADR-0005 candidate.

## References

- **REF-001**: ADR-0001 (record architecture decisions), ADR-0002 (use Terraform for IaC).
- **REF-002**: Azure Well-Architected Framework — Reliability pillar. <https://learn.microsoft.com/azure/well-architected/reliability/>
- **REF-003**: Azure paired regions. <https://learn.microsoft.com/azure/reliability/cross-region-replication-azure>
