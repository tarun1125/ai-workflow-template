# Stage 2: Safe Implementation
# Project: {{PROJECT_NAME}} | Workflow: Brownfield
# =============================================================================
# PURPOSE
# Make the change safely, in a controlled sequence.
# Fix the target problem without breaking anything adjacent.
# =============================================================================

## Entry condition
blast_radius.md complete. Risk classification approved.
Regression anchor tests written and passing on pre-change code.

## Order of operations (enforced — no skipping)

1. Confirm blast_radius.md is complete
2. Confirm regression anchor tests pass on the CURRENT code
3. Make the smallest possible change first (not the full change)
4. Run regression anchor tests — if failing, stop and diagnose
5. Review git diff — confirm only intended files changed
6. Expand the change incrementally (one logical unit at a time)
7. Repeat steps 4-5 after each increment
8. Add or update logging at any function you modified

## Code quality checklist per change

- [ ] Only files in the blast radius were modified (check diff)
- [ ] Logging preserved or added at modified function entry/exit
- [ ] No silent failures introduced (bare except or equivalent not allowed)
- [ ] No hardcoded values added (use config or constants)
- [ ] Input validation preserved or strengthened at data boundaries
- [ ] Windows-compatible paths used (pathlib.Path or os.path — not hardcoded slashes)
- [ ] For LLM calls (if any): chunking, schema validation, retry logic present

## Stop conditions

Stop and surface to human if:
- Regression anchor tests fail after a change — do not push through
- git diff shows files outside the declared blast radius changed
- The change required modifying more files than the blast radius predicted
- You are uncertain whether the change is correct

When stopping: show the exact state (what changed, what failed) before asking.

## Exit artifact
- Source code change complete
- All unit tests passing
- All regression anchor tests passing
- git diff reviewed and limited to declared blast radius

## Gate check (all must be true before Stage 3)
- [ ] Unit tests passing
- [ ] Regression anchor tests passing
- [ ] git diff clean — no unintended files
- [ ] Human has reviewed the diff
