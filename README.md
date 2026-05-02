# ai-workflow-template

A structured, session-aware AI-assisted development workflow for VS Code + Claude Code.
Designed for solo ML/AI developers who want SDLC discipline without bureaucracy.
**Windows-native** — all commands and paths are PowerShell compatible.

---

## What this is

A `.workflow\` folder you drop into any project. It gives Claude Code:
- Standing instructions that govern every session (`AGENTS.md`)
- Stage-gate checklists that enforce the right order of operations
- A session state file that survives between sessions (`session.md`)
- A memory system that captures lessons and injects only what is relevant
- Architectural decision records for decisions you don't want to rethink

It is a **protocol**, not a framework. No dependencies. No runtime. Just files.

---

## One-time setup

### 1. Fork or clone this repo to your GitHub account

Create a new repo on GitHub called `ai-workflow-template`, then:

```powershell
git clone https://github.com/YOUR_USERNAME/ai-workflow-template.git
cd ai-workflow-template
```

### 2. Set the environment variable (permanent, user-level)

```powershell
[System.Environment]::SetEnvironmentVariable(
    "WORKFLOW_TEMPLATE_REPO",
    "https://github.com/YOUR_USERNAME/ai-workflow-template.git",
    "User"
)
```

Verify it's set (restart terminal first, or run the line below to load it in the current session):

```powershell
$env:WORKFLOW_TEMPLATE_REPO = [System.Environment]::GetEnvironmentVariable("WORKFLOW_TEMPLATE_REPO","User")
Write-Host $env:WORKFLOW_TEMPLATE_REPO
```

### 3. Make workflow-init available globally

Add the folder containing `init.ps1` to your user PATH:

```powershell
$scriptDir = "C:\path\to\ai-workflow-template"   # ← update this to your actual path
$current = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", "$current;$scriptDir", "User")
```

Restart your terminal, then verify:

```powershell
workflow-init -Type greenfield -Domain ml
# Should run the script, not "command not found"
```

### 4. Allow PowerShell scripts to run (if not already set)

If you get a security error running the script:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Usage — new project

Open a PowerShell terminal in your project directory and run:

```powershell
# Greenfield ML project
.\path\to\init.ps1 -Type greenfield -Domain ml

# Brownfield general project
.\path\to\init.ps1 -Type brownfield -Domain general

# With explicit project name
.\path\to\init.ps1 -Type greenfield -Domain ml -Name my-rag-pipeline

# If init.ps1 is in your PATH (after step 3 above):
workflow-init -Type greenfield -Domain ml
```

Then open VS Code in the project, start Claude Code, and say:

> *"Read .workflow/AGENTS.md and .workflow/session.md.
> Tell me what you loaded, your confidence level, and the current task. Then let's begin."*

---

## Structure after init

```
.workflow\
├── AGENTS.md                    ← Claude Code reads this first, every session
├── session.md                   ← Live state: current task, decisions, next steps
│
├── memory\
│   ├── index.md                 ← Tag index — used for selective memory injection
│   └── entries\                 ← One JSON file per lesson learned (empty at start)
│
├── decisions\
│   └── ADR-000-*.md             ← Architectural Decision Records
│
├── stages\
│   ├── greenfield\              ← 6 stage-gate files (if -Type greenfield)
│   │   ├── 00_problem.md
│   │   ├── 01_requirements.md
│   │   ├── 02_architecture.md
│   │   ├── 03_implementation.md
│   │   ├── 04_testing.md
│   │   └── 05_validation.md
│   ├── brownfield\              ← 4 stage-gate files (if -Type brownfield)
│   │   ├── 00_understand.md
│   │   ├── 01_blast_radius.md
│   │   ├── 02_implement.md
│   │   └── 03_regression.md
│   └── ml_branch\              ← Added if -Domain ml (works with either type)
│       ├── eval_criteria.md
│       └── experiment_log.md
│
└── templates\
    ├── session_template.md      ← Format for session.md updates
    ├── memory_entry.json        ← Template for new memory entries
    └── adr_template.md          ← Template for new ADRs
```

---

## The session loop

**Start of session:**
```
Claude reads AGENTS.md + session.md + relevant memory
→ states current task + confidence level
```

**During session:**
```
Follow current stage file checklist
→ stop conditions enforced
→ work proceeds
```

**End of session (mandatory — do not skip):**
```
Claude updates session.md
→ decisions, next steps, blockers, memory entries
```

---

## Memory system

Memory lives in each **project's** `.workflow\memory\entries\` — not in this template repo.
Each project accumulates its own lessons.

To add a memory entry:
1. Copy `.workflow\templates\memory_entry.json` to `.workflow\memory\entries\<id>.json`
2. Fill in all fields
3. Add a row to `.workflow\memory\index.md`

Claude Code loads only entries whose tags match the current task — never the full memory dump.

---

## Keeping the template up to date

When you improve the workflow (better checklist, new stop condition, updated AGENTS.md):

1. Edit the file directly in this repo
2. Commit and push to GitHub
3. The next `workflow-init` run will pull the latest automatically

Your improvements accumulate here. Every new project benefits from past lessons.

---

## Claude Code cheat sheet

| What to say | When |
|-------------|------|
| `"Read AGENTS.md and session.md, then let's begin"` | Start of every session |
| `"Update session.md and end the session"` | End of every session |
| `"Read stage file X and tell me the gate check status"` | Before advancing a stage |
| `"What memory entries are relevant to [task]?"` | Before a complex task |
| `"Create a memory entry for this lesson"` | After any significant learning |
| `"Write an ADR for this decision"` | After a significant architectural choice |

---

## Troubleshooting

**Script won't run — execution policy error**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**WORKFLOW_TEMPLATE_REPO not found after setting it**
The env var is set at user level but the current terminal session needs a restart to pick it up.
Either restart PowerShell, or run:
```powershell
$env:WORKFLOW_TEMPLATE_REPO = [System.Environment]::GetEnvironmentVariable("WORKFLOW_TEMPLATE_REPO","User")
```

**git clone fails**
Check that git is installed and in your PATH:
```powershell
git --version
```
If not found, install Git for Windows from https://git-scm.com/download/win

**init.ps1 not found as a command**
Confirm the folder containing init.ps1 is in your PATH (step 3 of setup).
Or run it with the full path:
```powershell
& "C:\path\to\ai-workflow-template\init.ps1" -Type greenfield -Domain ml
```
