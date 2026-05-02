# ADR-000: Workflow Template Adopted
# Date   : {{DATE}}
# Status : Accepted
# Project: {{PROJECT_NAME}}

## Context
This project uses the ai-workflow-template to enforce SDLC discipline
in an AI-assisted development environment (VS Code + Claude Code).

## Decision
Adopt the structured workflow defined in .workflow\ for all development
work in this project — greenfield or brownfield.

## Rationale
Ad-hoc LLM-assisted coding produces components that work in isolation
but fail at integration. A protocol-based workflow forces interface
contracts to be defined before implementation, and ensures session
continuity and memory across a project's lifetime.

## Consequences
**Positive:**
- Structured stage gates catch ambiguity early
- Interface contracts defined before code prevent integration failures
- Memory system captures lessons learned across sessions

**Negative / Tradeoffs:**
- Overhead per session (reading AGENTS.md, updating session.md)
- Workflow may feel slow for very small one-off scripts

## Review trigger
If more than 3 projects completed and overhead consistently outweighs
benefit, revisit and simplify the protocol.
