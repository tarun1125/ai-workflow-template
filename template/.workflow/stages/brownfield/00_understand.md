# Stage 0: Codebase Understanding
# Project: {{PROJECT_NAME}} | Workflow: Brownfield
# =============================================================================
# PURPOSE
# Build a map before touching anything.
# You cannot safely change what you don't understand.
# The cost of reading first is minutes. The cost of skipping is hours.
# =============================================================================

## Entry condition
A task exists: a bug report, enhancement request, or refactoring goal.

## Absolute rule
No code changes until this stage is documented and human-approved.

## What to map

### Entry points
- Where does data / requests enter the system?
- What are the main executables, scripts, or entry modules?

### Dependency map (affected area only — not the whole codebase)
- What calls what? (at function / module level)
- What external dependencies does the affected code rely on?
- What configuration or environment variables does it read?

### Danger zones
- What has no test coverage in or near the affected area?
- What is tightly coupled? (touching one thing cascades to many)
- What is undocumented or poorly named?
- Where are the data boundaries? (input enters, output leaves)

## Claude Code: questions to answer

- [ ] What is the exact scope of this task? (bug fix / enhancement / refactor — be specific)
- [ ] Which files are directly relevant to the task?
- [ ] Which files might be indirectly affected?
- [ ] What tests currently cover the affected area? (run them, confirm they pass pre-change)
- [ ] Can the bug or target behaviour be reproduced locally? How?
- [ ] Is there existing logging that helps diagnose the problem?

## Exit artifact
entry_points.md in .workflow\ containing:
- Task scope (one sentence)
- Relevant files list (direct + indirect)
- Dependency map for the affected area
- Danger zones flagged (untested, tightly coupled, undocumented)
- Current test coverage status for the affected path

## Gate check (all must be true before Stage 1)
- [ ] entry_points.md complete
- [ ] Human has reviewed and confirmed the scope
- [ ] Existing tests run and passing (pre-change baseline confirmed)
- [ ] No changes made to source code yet
