# ML Eval Criteria
# Project: {{PROJECT_NAME}}
# =============================================================================
# PURPOSE
# Define success metrics BEFORE running any experiment.
# A metric defined after seeing results is not a metric — it is a rationalization.
#
# WHEN TO FILL THIS IN
# Greenfield: complete this during Stage 2 (Architecture), before Stage 3.
# The eval targets shape your architecture decisions.
# =============================================================================

## Rule
Do not begin Stage 4 (Testing) without this file fully complete.
Do not interpret results without consulting this file.

---

## Metrics

| Metric | Minimum acceptable | Target | How measured |
|--------|--------------------|--------|--------------|
|        |                    |        |              |

Examples: Recall@5, MRR, NDCG@5, F1, BLEU, accuracy, latency p95
Be specific: "Recall@5 > 0.70 on held-out eval set" not just "good recall"

---

## Eval dataset

- Source:
- Total size:
- Train / Val / Test split:
- Known biases or gaps in the data:
- How representative is this of production inputs?

---

## Baseline

What is the minimum bar to beat?
(Random / heuristic / previous model version / human baseline)

Baseline metric values:
- [metric]: [value]

---

## Failure definition

The model or system has FAILED evaluation if:
- Any metric falls below the minimum acceptable threshold

On failure:
- Do NOT proceed to Stage 5
- Log the result in experiment_log.md
- Debug in this order: data quality → model config → architecture → prompt/retrieval design
- Re-run from the beginning of Stage 4

---

## Sign-off
This file must be approved by the human before any experiment is run.

Approved by: ___________
Date: ___________
