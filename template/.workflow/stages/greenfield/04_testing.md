# Stage 4: Testing
# Project: {{PROJECT_NAME}} | Workflow: Greenfield
# =============================================================================
# PURPOSE
# Prove that components work TOGETHER, not just in isolation.
# "All tests pass" proves unit correctness. It does not prove integration.
# This stage proves the integration.
# =============================================================================

## Entry condition
All components implemented. Unit + contract tests passing (Stage 3 gate met).

## Three test levels — all required

### Level 1: Unit tests
Already written in Stage 3. Re-run to confirm still passing.

```powershell
pytest tests\unit\
```

### Level 2: Contract tests
Does each component honour its interface contract?
Test the boundary, not the internal implementation.
Input → component → assert output matches contract shape and type.

```powershell
pytest tests\contract\
```

### Level 3: Integration tests
Do all components work together end-to-end?
Test the full data path: from system entry point to final output.

Minimum required:
- [ ] One happy path: valid input → expected output
- [ ] One failure path: bad input or downstream failure → graceful handling (no crash, logged)
- [ ] One edge case specific to this project

```powershell
pytest tests\integration\
```

## For ML projects (domain=ml)
Run evaluation as defined in .workflow\stages\ml_branch\eval_criteria.md:
- [ ] Eval dataset loaded correctly
- [ ] Metrics computed against defined targets
- [ ] Results recorded in .workflow\stages\ml_branch\experiment_log.md
- [ ] If ANY metric below minimum threshold: STOP. Do not proceed to Stage 5. Debug.

## For UI components (Streamlit, web)

Before writing any UI code, write a layout spec:
```
Layout spec for <component name>:
- Header: [what it shows]
- Input section: [fields, types, placement]
- Output section: [what renders, when, under what condition]
- State: [what triggers re-render]
- Error state: [what the user sees on failure]
```

Build to the spec. Not by feel.
After implementation: walk through each spec item and confirm it renders correctly.

## Exit artifact
Test report (markdown or captured pytest output):
- Level 1 results
- Level 2 results
- Level 3 results
- For ML: eval results vs targets

## Gate check (all must be true before Stage 5)
- [ ] All three test levels passing
- [ ] For ML: all metrics at or above minimum acceptable threshold
- [ ] For UI: layout spec written and every item confirmed
- [ ] Human has reviewed test report
