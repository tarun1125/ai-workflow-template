# Stage 2: Architecture & Interface Design
# Project: {{PROJECT_NAME}} | Workflow: Greenfield
# =============================================================================
# PURPOSE
# Define component boundaries and interfaces BEFORE any code is written.
# This stage exists specifically to prevent the integration failure mode:
# "each part works in isolation, but they don't work together."
#
# The root cause of that failure is always the same:
# interfaces were assumed, not designed.
# =============================================================================

## Entry condition
requirements.md exists, is approved, and has no unresolved [OPEN] items.

## The Interface Contract Rule

Every component must have a written contract before implementation begins:

```
Component: <name>
Input:
  - param: type, shape, constraints, example
Output:
  - field: type, shape, what it represents
Failure modes:
  - what can go wrong and how the component signals it
Side effects:
  - what does it touch beyond its return value? (DB, file, external API)
```

No component may be implemented without its contract existing in writing.
If you cannot write the contract, you do not understand the component yet.

## Claude Code: questions to answer before exiting this stage

- [ ] What are the top-level components? (Name each one.)
- [ ] What does each component receive as input? (type + shape + validation rules)
- [ ] What does each component return? (type + shape + error cases)
- [ ] How do components communicate? (direct function call / queue / event / HTTP)
- [ ] Where is the data boundary? (what enters the system, what leaves it)
- [ ] Which components are stateful vs stateless?
- [ ] What fails first under bad input or unexpected load?
- [ ] Which component carries the highest implementation risk? (Address it first.)

For ML projects: complete .workflow\stages\ml_branch\eval_criteria.md NOW,
before architecture is finalised. Eval targets shape architecture decisions.

## Exit artifacts

architecture.md containing:
- Component list with one-line description of each
- Data flow diagram (ASCII or Mermaid — text is fine)
- Key architectural decisions and rationale
- Risk assessment: which components are highest risk and why

interface_contracts.md containing:
- One interface contract block per component (format above)
- Every field typed. No "any" or "dict" without justification.

For ML: eval_criteria.md (see ml_branch stage) must also be complete.

## Gate check (all must be true before Stage 3)
- [ ] Every component has an interface contract in interface_contracts.md
- [ ] No implementation has started (check git status — no new src\ files)
- [ ] Human has approved architecture.md
- [ ] For ML: eval_criteria.md is complete with numeric metric targets
