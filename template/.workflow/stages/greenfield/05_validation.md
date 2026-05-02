# Stage 5: Validation & Close-Out
# Project: {{PROJECT_NAME}} | Workflow: Greenfield
# =============================================================================
# PURPOSE
# Close the loop. Does the built system actually solve the original problem?
# Capture what was learned. Feed it into memory for the next project.
# =============================================================================

## Entry condition
All three test levels passing. Stage 4 gate met.

## Validation checklist

- [ ] Re-read problem_statement.md
- [ ] For each "done" criterion in problem_statement.md: is it met? Document evidence.
- [ ] For each [ASSUMED] requirement in requirements.md: was the assumption correct?
      If wrong: document what was true and what signal you missed.
- [ ] Any surprises during the build? Document them.
- [ ] What would you design differently if starting over?

## Memory harvest (mandatory — do not skip)

For every lesson learned, create an entry in .workflow\memory\entries\.
Use the template at .workflow\templates\memory_entry.json.
Update the index at .workflow\memory\index.md.

Categories to look for:

Bug that escaped:
What failed, why the tests didn't catch it, how to prevent it.

Wrong assumption:
What you assumed, what was actually true, the signal you missed.

Repeated friction:
What kept slowing you down that a process change could fix.

Architectural decision:
What you chose, what you rejected, the tradeoff in practice (not just theory).

Minimum: 1 memory entry per project. Target: 1 per major decision or surprise.

## Sign-off

Add this block when validation is complete:

```
## Sign-off
Date: YYYY-MM-DD
All problem_statement.md criteria met: Yes / No (list exceptions)
Memory entries created: [list IDs]
Known gaps deferred to v2: [list or "none"]
```

## Exit artifact
- This file with sign-off block completed
- Memory entries created in .workflow\memory\entries\
- session.md updated with final state
- (Optional) ADR written for any significant architectural decision

## Gate check
- [ ] Sign-off block complete
- [ ] At least one memory entry written
- [ ] session.md reflects final state
- [ ] Human has signed off
