# Stage 3: Implementation
# Project: {{PROJECT_NAME}} | Workflow: Greenfield
# =============================================================================
# PURPOSE
# Build to the interface contracts. One component at a time.
# Not to vibes. Not to "I think it should work like this."
# The contract is the spec. The contract is the test.
# =============================================================================

## Entry condition
architecture.md and interface_contracts.md are complete and approved.
No [OPEN] requirements affect the component being built.

## Order of operations (enforced — no skipping steps)

For each component, in sequence:

1. Read the interface contract for this component
2. Load relevant memory entries (check .workflow\memory\index.md)
3. Write the unit test shell first (what does success look like?)
4. Implement the component
5. Validate: does it honour its interface contract?
6. Run tests — must pass before moving to the next component
7. Review git diff — confirm only intended files changed
8. Log the completion in session.md

Do NOT implement all components first and test at the end.

## Per-component implementation checklist

- [ ] Interface contract read and understood
- [ ] Logging added at function entry (log inputs) and exit (log output or error)
- [ ] No silent failures — every exception is caught, logged, and re-raised or handled
- [ ] For any LLM call:
  - [ ] Input chunked if > 5k tokens
  - [ ] Output validated against schema (Pydantic or equivalent)
  - [ ] Retry logic present (at least 1 retry with backoff)
- [ ] Unit test written and passing
- [ ] Contract test written: does the output match the interface contract shape?
- [ ] git diff reviewed — no unintended changes
- [ ] Windows paths used throughout (use pathlib.Path, not hardcoded forward slashes)

## Stop conditions
- Same implementation approach failed twice → STOP, surface the problem
- Uncertainty on how to implement a contract → STOP, revisit architecture first
- Test failing and cause unclear after two attempts → STOP, ask

## Exit artifact
Working code per component with:
- Unit tests passing
- Contract tests passing
- All components in architecture.md implemented

## Gate check (all must be true before Stage 4)
- [ ] All components implemented
- [ ] Unit + contract tests passing for every component
- [ ] No component skipped its interface contract
- [ ] git diff clean — no unintended files
- [ ] session.md updated with implementation decisions
