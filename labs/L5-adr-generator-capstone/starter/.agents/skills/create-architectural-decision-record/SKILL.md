---
name: create-architectural-decision-record
description: 'Create an Architectural Decision Record (ADR) document for AI-optimized decision documentation.'
---

# Create Architectural Decision Record

Create an ADR document for `${input:DecisionTitle}` using structured formatting optimized for AI consumption and human readability.

<!--
SOURCE: github/awesome-copilot · skills/create-architectural-decision-record/SKILL.md
https://github.com/github/awesome-copilot/blob/main/skills/create-architectural-decision-record/SKILL.md

This file is the upstream version — your job in L5 is to CUSTOMIZE it for your
team. Look for "TODO (org)" markers below for the natural extension points.

Update freely. The agent reads whatever you save here.
-->

## Inputs

- **Context**: `${input:Context}`
- **Decision**: `${input:Decision}`
- **Alternatives**: `${input:Alternatives}`
- **Stakeholders**: `${input:Stakeholders}`

<!-- TODO (org): If your team needs extra inputs (e.g. "Compliance framework",
     "Cost owner", "Security reviewer"), add them here so the agent prompts for them. -->

## Input Validation
If any of the required inputs are not provided or cannot be determined from the conversation history, ask the user to provide the missing information before proceeding with ADR generation.

## Requirements

- Use precise, unambiguous language
- Follow standardized ADR format with front matter
- Include both positive and negative consequences
- Document alternatives with rejection rationale
- Structure for machine parsing and human reference
- Use coded bullet points (3-4 letter codes + 3-digit numbers) for multi-item sections
- Must be linked to a company-wide ADR index or registry for discoverability

<!-- TODO (org): Append team-specific requirements here. Examples:
     - "Every infra ADR MUST reference the relevant Azure Well-Architected pillar"
     - "Every ADR touching data residency MUST cite the policy doc by ID"
     - "Tag each ADR with the cost centre that owns the decision"
-->

The ADR must be saved in the `/docs/adr/` directory using the naming convention: `adr-NNNN-[title-slug].md`, where NNNN is the next sequential 4-digit number (e.g., `adr-0001-database-selection.md`).

<!-- TODO (org): Adjust path / naming if your team uses a different location
     (e.g., `architecture/decisions/`, `docs/architecture/adr/`) or convention
     (e.g., `YYYY-MM-DD-slug.md`). The agent will follow whatever this skill says. -->

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
---

# ADR-NNNN: [Decision Title]

## Status

**Proposed** | Accepted | Rejected | Superseded | Deprecated

## Context

[Problem statement, technical constraints, business requirements, and environmental factors requiring this decision.]

## Decision

[Chosen solution with clear rationale for selection.]

## Consequences

### Positive

- **POS-001**: [Beneficial outcomes and advantages]
- **POS-002**: [Performance, maintainability, scalability improvements]
- **POS-003**: [Alignment with architectural principles]

### Negative

- **NEG-001**: [Trade-offs, limitations, drawbacks]
- **NEG-002**: [Technical debt or complexity introduced]
- **NEG-003**: [Risks and future challenges]

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

<!-- TODO (org): If you want extra sections (e.g. "Security review", "Cost impact",
     "Operational readiness"), add them above and update the agent's checklist to
     produce them. -->
