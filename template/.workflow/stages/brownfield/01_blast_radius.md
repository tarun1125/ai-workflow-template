# Stage 1: Blast Radius Analysis
# Project: {{PROJECT_NAME}} | Workflow: Brownfield
# =============================================================================
# PURPOSE
# Before any change: know exactly what you might break.
# Blast radius = the set of files, functions, and behaviours
# that could be affected by the proposed change.
# =============================================================================

## Entry condition
entry_points.md complete. Task scope agreed. Pre-change tests passing.

## Analysis checklist

- [ ] List every file that will directly change
- [ ] List every file that imports or calls the code being changed
- [ ] List every test that currently covers the affected path
- [ ] List every path in the blast radius with NO test coverage (highest risk)
- [ ] Identify any shared state, global config, or environment variables touched

## Risk classification

| Blast radius                         | Risk   | Required action before proceeding      |
|--------------------------------------|--------|----------------------------------------|
| 1-2 files, well-tested paths         | Low    | Proceed to Stage 2                     |
| 3-5 files, partial test coverage     | Medium | Write regression anchor tests first    |
| 5+ files OR any untested paths       | High   | STOP — confirm with human before any changes |

If High: present the full blast radius map to the human and wait for explicit approval.
Do not propose a workaround to avoid the stop. Surface it honestly.

## The regression anchor rule (mandatory for Medium and High)

Before making any change:
1. Write tests that document the CURRENT behaviour — even if that behaviour is wrong
2. These tests must PASS on the pre-change code
3. Make the change
4. Run tests — regression anchors must still pass (except the one being intentionally fixed)

This gives you a safety net. Without it, you cannot tell if something broke
vs if it was already broken.

## Exit artifact
blast_radius.md in .workflow\ containing:
- Direct files changing
- Indirect files affected
- Test coverage map for the blast radius
- Risk classification
- Regression anchor tests written (with location in test suite)

## Gate check (all must be true before Stage 2)
- [ ] blast_radius.md complete
- [ ] Risk classification determined
- [ ] For Medium/High: regression anchor tests written AND passing on pre-change code
- [ ] For High: human has explicitly approved proceeding
