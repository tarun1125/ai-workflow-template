# Stage 1: Requirements
# Project: {{PROJECT_NAME}} | Workflow: Greenfield
# =============================================================================
# PURPOSE
# Build a confidence-tagged list of requirements.
# This is NOT a requirements freeze. It is a progressive commitment ladder.
# Requirements become more specific as we learn — they do not lock early.
# =============================================================================

## Entry condition
problem_statement.md exists and is human-approved.

## Confidence tags (apply to every requirement)

| Tag         | Meaning                                                    |
|-------------|------------------------------------------------------------|
| [CONFIRMED] | Verified against a real need or hard constraint            |
| [ASSUMED]   | Reasonable assumption, not yet validated                   |
| [OPEN]      | Unresolved — needs a decision before architecture begins   |

Rule: Do NOT design architecture around [OPEN] requirements.
Rule: Flag [ASSUMED] items explicitly — they are risks, not facts.

## Claude Code: questions to answer per requirement

For each requirement the human proposes:
- What is the source? (user need / technical constraint / personal assumption)
- What breaks if this requirement turns out to be wrong?
- Can we defer this to v2 and still ship a useful v1?

If a requirement is vague: ask for specificity before accepting it.
Example: "fast" is not a requirement. "Response under 2s at p95" is.

## Requirement categories

### Functional requirements
What the system does — user-facing behaviours and capabilities.

### Non-functional requirements
How well it does it — performance, reliability, security, maintainability.

### Out-of-scope (explicit list)
What the system will NOT do in this version.

## Exit artifact
requirements.md in the project root with:
- Functional requirements, each tagged [CONFIRMED] / [ASSUMED] / [OPEN]
- Non-functional requirements, each tagged
- Explicit out-of-scope list
- Summary: how many [OPEN] items remain and what is needed to resolve them

## Gate check (all must be true before Stage 2)
- [ ] Every requirement has a confidence tag
- [ ] No [OPEN] items affect Stage 2 architecture (resolve or explicitly defer)
- [ ] [ASSUMED] items are listed and acknowledged by the human as risks
- [ ] Human has approved requirements.md
