---
name: create-architectural-decision-record
description: 'Create an Architectural Decision Record (ADR) document for AI-optimized decision documentation.'
---

# Create Architectural Decision Record

Create an ADR document for `${input:DecisionTitle}` using structured formatting optimized for AI consumption and human readability.

<!--
SOURCE: github/awesome-copilot · skills/create-architectural-decision-record/SKILL.md

CUSTOMIZED for the Helios sample workload. Reference org-extensions are marked
with [ORG] in this solution copy. Drop them or swap them for your own.
-->

## Inputs

- **Context**: `${input:Context}`
- **Decision**: `${input:Decision}`
- **Alternatives**: `${input:Alternatives}`
- **Stakeholders**: `${input:Stakeholders}`
- **[ORG] WAF pillar primarily served**: `${input:WafPillar}` — one of Security, Reliability, Performance Efficiency, Cost Optimization, Operational Excellence.
- **[ORG] Cost owner**: `${input:CostOwner}` — the team/cost-centre that picks up the bill.

## Input Validation

If any of the required inputs are not provided or cannot be determined from the conversation history, ask the user to provide the missing information before proceeding with ADR generation. The two `[ORG]` inputs are required for any infra-related ADR; for non-infra ADRs (e.g. process, tooling) they may be left empty.

## Requirements

- Use precise, unambiguous language
- Follow standardized ADR format with front matter
- Include both positive and negative consequences
- Document alternatives with rejection rationale
- Structure for machine parsing and human reference
- Use coded bullet points (3-4 letter codes + 3-digit numbers) for multi-item sections
- **[ORG] WAF alignment.** Every infra ADR MUST name one primary Azure Well-Architected Framework pillar in the `waf_pillar` front-matter field and explain (in Decision) how the choice supports it.
- **[ORG] IaC stance.** Per ADR-0002, default IaC is Terraform; if you propose anything else, an explicit alternative rejection is required.
- **[ORG] Cost transparency.** Any cost-impacting decision MUST have an estimated monthly delta in at least one `NEG-XXX` bullet (use "$/mo ±N" or "negligible").

The ADR must be saved in the `/docs/adr/` directory using the naming convention: `adr-NNNN-[title-slug].md`, where NNNN is the next sequential 4-digit number (e.g., `adr-0001-database-selection.md`).

## Required Documentation Structure

The documentation file must follow the template below, ensuring that all sections are filled out appropriately. The front matter for the markdown should be structured correctly as per the example following:

```md
---
title: "ADR-NNNN: [Decision Title]"
status: "Proposed"
date: "YYYY-MM-DD"
authors: "[Stakeholder Names/Roles]"
tags: ["architecture", "decision"]
supersedes: ""
superseded_by: ""
waf_pillar: ""        # [ORG] one of: Security | Reliability | Performance Efficiency | Cost Optimization | Operational Excellence
cost_owner: ""        # [ORG] cost-centre or team handle
---

# ADR-NNNN: [Decision Title]

## Status

**Proposed** | Accepted | Rejected | Superseded | Deprecated

## Context

[Problem statement, technical constraints, business requirements, and environmental factors requiring this decision.]

## Decision

[Chosen solution with clear rationale for selection. **[ORG]** State the primary WAF pillar this decision serves and why.]

## Consequences

### Positive

- **POS-001**: [Beneficial outcomes and advantages]
- **POS-002**: [Performance, maintainability, scalability improvements]
- **POS-003**: [Alignment with architectural principles]

### Negative

- **NEG-001**: [Trade-offs, limitations, drawbacks]
- **NEG-002**: [Technical debt or complexity introduced]
- **NEG-003**: [Risks and future challenges — include estimated monthly cost delta if applicable]

## Alternatives Considered

### [Alternative 1 Name]

- **ALT-001**: **Description**: [Brief technical description]
- **ALT-002**: **Rejection Reason**: [Why this option was not selected]

### [Alternative 2 Name]

- **ALT-003**: **Description**: [Brief technical description]
- **ALT-004**: **Rejection Reason**: [Why this option was not selected]

## Implementation Notes

- **IMP-001**: [Key implementation considerations]
- **IMP-002**: [Migration or rollout strategy if applicable]
- **IMP-003**: [Monitoring and success criteria]

## References

- **REF-001**: [Related ADRs]
- **REF-002**: [External documentation]
- **REF-003**: [Standards or frameworks referenced]
```
