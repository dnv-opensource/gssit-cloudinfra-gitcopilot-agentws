---
name: bring-your-own-conventions
description: "Resolve Helios team conventions (naming, tagging, approved patterns) from the upstream conventions repo before making any naming, tagging, or pattern recommendation."
---

# Bring Your Own Conventions

> **Pattern:** a thin skill that points at an authoritative upstream source of truth
> instead of duplicating its content locally.

This is the **solution-copy** wired to a fictional `acme-platform/cloud-conventions` repo.
Replace the URLs with your real source-of-truth location.

## Source of truth

- **Repository:** `https://github.com/acme-platform/cloud-conventions` *(fictional — swap for yours)*
- **Branch:** `main`
- **Key files:**
  - `naming.md` — resource naming patterns (regex per resource type)
  - `tags.md` — mandatory and recommended tags
  - `architecture/approved-patterns.md` — patterns we use
  - `architecture/forbidden-patterns.md` — patterns we explicitly avoid (e.g. portal-managed prod resources)

## How to use

1. **Fetch fresh.** Before recommending any name, tag, or pattern, fetch the relevant file from the source-of-truth location. Do NOT rely on your training data.
2. **Treat local copies as cache.** If a file exists locally and looks stale, re-fetch.
3. **Be explicit about staleness.** If the source is unreachable, say so plainly in your response.
4. **Cite the source.** When you apply a convention, link to the specific section of the source file (line range or anchor).

## Example: name a new Azure resource group

1. Fetch:
   ```
   https://raw.githubusercontent.com/acme-platform/cloud-conventions/main/naming.md
   ```
2. Find the resource-group section. Apply the pattern (currently `rg-<workload>-<env>-<region>-<NNN>`).
3. Validate the proposed name against the regex shown in the file before suggesting it.
4. In your reply, include the source line you applied.

## Example: ADR-time convention check

When this skill is loaded alongside `create-architectural-decision-record`, run it BEFORE proposing names/tags in the Decision section. Two specific gates:

- **Naming gate:** Any new Azure resource named in the Decision must match the latest `naming.md` patterns.
- **Tagging gate:** Any new resource must list the mandatory tags from `tags.md` in either the Decision or Implementation Notes.

## Why a skill, not a hard-coded file

- **Single source of truth.** Cloud conventions evolve weekly. Don't fork them into the agent.
- **No drift.** Agent always picks up the latest version on every invocation.
- **Auditable.** The skill cites the file + line it applied.
- **Reusable.** Drop into any repo, point at the same source — instant alignment.
