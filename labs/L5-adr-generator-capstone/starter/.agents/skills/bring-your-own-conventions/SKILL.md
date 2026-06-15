---
name: bring-your-own-conventions
description: "Resolve team conventions (naming, tagging, approved patterns) from the authoritative upstream conventions repo before making any naming, tagging, or pattern recommendation."
---

# Bring Your Own Conventions

> **Pattern:** a thin skill that points at an authoritative upstream source of truth
> instead of duplicating its content locally. Keeps the agent aligned with whatever
> your team is *actually* maintaining today.

<!-- TODO (org): This is a SKELETON. Wire it up to your real conventions repo.
     The whole point is that this skill stays tiny and the source of truth lives
     where your team already updates it. -->

## Source of truth

<!-- TODO (org): Replace these placeholders with your real conventions repo. -->

- **Repository:** `https://github.com/<your-org>/<your-conventions-repo>` *(replace me)*
- **Branch:** `main`
- **Key files:**
  - `naming.md` — resource naming patterns
  - `tags.md` — mandatory and recommended tags
  - `architecture/approved-patterns.md` — patterns we use
  - `architecture/forbidden-patterns.md` — patterns we explicitly avoid

If your conventions live somewhere other than a public GitHub repo (internal GHE, SharePoint, Confluence, an internal docs site), update the fetch instructions below accordingly.

## How to use

1. **Fetch fresh.** Before recommending any name, tag, or pattern, fetch the relevant file from the source-of-truth location. Do NOT rely on your training data — your team's conventions evolve.
2. **Treat local copies as cache.** If a file exists locally and looks stale (older than a sprint, or you have no metadata), re-fetch.
3. **Be explicit about staleness.** If the source is unreachable (offline, 404, expired token), say so plainly in your response. Do NOT guess at a convention you can't verify.
4. **Cite the source.** When you apply a convention, link to the specific section of the source file you applied (line range or anchor).

## Example: name a new Azure resource group

1. Fetch the raw naming file:
   ```
   https://raw.githubusercontent.com/<your-org>/<your-conventions-repo>/main/naming.md
   ```
2. Find the resource-group section. Apply the pattern (e.g. `rg-<workload>-<env>-<region>-<NNN>`).
3. Validate the proposed name against any regex shown in the conventions file before suggesting it.
4. In your reply, include the source line you applied so the human can audit it.

## Example: ADR-time convention check

When this skill is loaded alongside `create-architectural-decision-record`, run it BEFORE proposing the ADR title and resource names in the Decision section. That keeps every ADR aligned with current conventions without you (the human) re-typing them.

<!-- TODO (org): Add other examples your agent will encounter frequently
     (e.g. "tag a new Terraform resource", "pick an Azure region",
     "name an App Service plan"). Each example should reference a specific
     section of the source-of-truth file. -->

## Why a skill, not a hard-coded file

- **Single source of truth.** Your team already updates conventions somewhere. Don't fork it into the agent.
- **No drift.** Agent always picks up the latest version on every invocation.
- **Auditable.** The skill cites the file + line it applied, so reviewers can verify.
- **Reusable.** Drop the same skill into any repo, point it at the same source — instant alignment.
