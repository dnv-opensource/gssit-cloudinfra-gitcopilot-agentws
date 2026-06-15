# 0001. Record architecture decisions

* Status: accepted
* Date: 2026-05-01

## Context

The "Helios" platform team for our fictional internal billing service has grown to
three squads. Significant architecture choices — datastore selection, tooling, network
topology — are currently captured only in chat threads and people's memory. New joiners
repeatedly ask "why was it done this way?" and there is no durable answer.

We need a lightweight, version-controlled way to record the *why* behind decisions
without introducing heavyweight documentation process.

## Decision

We will use Architecture Decision Records (ADRs) as described by Michael Nygard.
Each ADR is a short markdown file in `docs/adr/`, numbered sequentially, with Context,
Decision, and Consequences sections. ADRs are immutable once accepted; a changed decision
is captured as a new ADR that supersedes the old one.

## Consequences

* New team members can read the decision history in one folder, in chronological order.
* The cost of recording a decision is low (one small markdown file), so it actually happens.
* We must remember to write an ADR when a significant decision is made — this requires
  light discipline and is a good candidate for an AI agent to assist with.
