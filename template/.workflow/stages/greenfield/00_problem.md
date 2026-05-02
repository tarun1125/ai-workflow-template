# Stage 0: Problem Understanding
# Project: {{PROJECT_NAME}} | Workflow: Greenfield
# =============================================================================
# PURPOSE
# Force clarity on the problem before any solution thinking begins.
# A vague problem produces a vague system.
# You cannot design what you don't understand.
# =============================================================================

## Entry condition
A raw idea or problem statement exists (even informal is fine).

## Claude Code: questions to ask before this stage exits

Ask these in order. Do not proceed to Stage 1 until all are answered.
Tag each answer as [ANSWERED] or [DEFERRED: reason].

- [ ] Who is the user or consumer of this system?
- [ ] What is the failure mode if this system doesn't exist? (What pain does it solve?)
- [ ] What does "done" look like? (How will we know it worked?)
- [ ] What are we explicitly NOT building? (Scope boundary)
- [ ] What is the simplest version that still solves the core problem?
- [ ] Do existing tools already solve this? Why are we building instead of using them?

## Rules for this stage
- No solution design allowed here — problem only
- If you find yourself describing how to build it, stop and redirect
- If the human's answers are vague, ask follow-up questions before accepting them

## Exit artifact
`problem_statement.md` in the project root containing:
- The problem in one paragraph (plain language, no jargon)
- Who is affected and how
- What "done" looks like (measurable or observable)
- Explicit out-of-scope list

## Gate check (all must be true before Stage 1)
- [ ] All six questions answered or explicitly deferred with justification
- [ ] problem_statement.md exists in project root
- [ ] No solution or architecture described in problem_statement.md
- [ ] Human has read and approved problem_statement.md
