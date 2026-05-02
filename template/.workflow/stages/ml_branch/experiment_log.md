# Experiment Log
# Project: {{PROJECT_NAME}}
# =============================================================================
# HOW TO USE
# Add one entry per experiment run, in chronological order.
# NEVER delete old entries — they are your debugging history.
# If you run the same config twice, log both runs separately.
# Compare against targets in eval_criteria.md, not against each other.
# =============================================================================

## Entry format
Copy the template block below for each run.

---

## EXP-001

**Date:** YYYY-MM-DD
**Stage:** (e.g. Stage 4 - first eval run)

**Hypothesis:**
What did you expect to happen, and why?
(Write this BEFORE running. If you have no hypothesis, form one first.)

**Config changes from last run:**
What was different? (model, prompt, chunk size, retrieval strategy, data split, etc.)
First run: describe full config.

**Results:**

| Metric | Min threshold | Target | Actual | Pass? |
|--------|--------------|--------|--------|-------|
|        |              |        |        |       |

**Outcome:** PASS / FAIL / INCONCLUSIVE

**Observations:**
What actually happened? Surprises? Patterns in failures?
What does the data suggest about why this result occurred?

**Next action:**
- If PASS: proceed to Stage 5 / next experiment
- If FAIL: specific next debug step (not "try something else")
- If INCONCLUSIVE: what additional data or config is needed?

---
<!-- Add new experiment blocks above this line -->
