# Stage 3: Regression Validation
# Project: {{PROJECT_NAME}} | Workflow: Brownfield
# =============================================================================
# PURPOSE
# Confirm the full system is healthy — not just the changed path.
# Local tests passing is necessary but not sufficient.
# =============================================================================

## Entry condition
Stage 2 complete. Unit + regression anchor tests passing. Diff reviewed.

## Full validation checklist

- [ ] Run the FULL test suite (not just tests for changed files)

  ```powershell
  pytest
  ```

- [ ] Review complete git diff one final time against blast_radius.md
- [ ] Confirm no unintended files were modified
- [ ] If integration tests exist: run them
- [ ] If the system can be run locally: manually test the affected flow end-to-end
      (Do not rely only on automated tests for brownfield changes)
- [ ] Check logs from a local run — any unexpected warnings or errors?

## If the full suite reveals a regression

Do NOT push the change forward.
1. Identify the failing test
2. Determine: was this test passing before? (check via git stash or baseline branch)
3. If it was passing: your change broke it. Fix before proceeding.
4. If it was already failing: document it, confirm with human whether to fix now or defer.

## Memory harvest

Did anything surprise you during this change?
Surprises worth capturing:
- Unexpected coupling discovered during blast radius analysis
- A test that was silently not testing what it claimed to test
- An assumption in the existing code that turned out to be wrong
- A debugging approach that worked or failed

Create memory entries for anything worth remembering next time.

## Exit artifact
- Full test suite passing (or all failures pre-existing and documented)
- git diff confirmed clean
- session.md updated with what was done, decisions, and next steps
- Memory entries written for any lessons learned

## Gate check
- [ ] Full test suite run and results reviewed
- [ ] git diff confirmed clean
- [ ] session.md updated
- [ ] Human sign-off on the final change
