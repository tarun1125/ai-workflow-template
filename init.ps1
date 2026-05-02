# =============================================================================
# workflow-init.ps1 — AI-assisted development workflow scaffolder (Windows)
# Usage: .\init.ps1 -Type <greenfield|brownfield> -Domain <ml|general> [-Name <project-name>]
#
# Requirements:
#   - Git for Windows installed (git must be in PATH)
#   - WORKFLOW_TEMPLATE_REPO env var set to your GitHub template repo URL
#
# One-time setup:
#   [System.Environment]::SetEnvironmentVariable("WORKFLOW_TEMPLATE_REPO", "https://github.com/YOUR_USERNAME/ai-workflow-template.git", "User")
# =============================================================================

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("greenfield", "brownfield")]
    [string]$Type,

    [Parameter(Mandatory=$true)]
    [ValidateSet("ml", "general")]
    [string]$Domain,

    [Parameter(Mandatory=$false)]
    [string]$Name = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$LOG_PREFIX    = "[workflow-init]"
$SCRIPT_VERSION = "1.0.0"

# ── Helpers ───────────────────────────────────────────────────────────────────
function Log  { param($msg) Write-Host "$LOG_PREFIX $msg" }
function Warn { param($msg) Write-Warning "$LOG_PREFIX $msg" }
function Err  { param($msg) Write-Error   "$LOG_PREFIX ERROR: $msg"; exit 1 }

# ── Env var check ─────────────────────────────────────────────────────────────
$TemplateRepo = [System.Environment]::GetEnvironmentVariable("WORKFLOW_TEMPLATE_REPO", "User")
if (-not $TemplateRepo) {
    $TemplateRepo = $env:WORKFLOW_TEMPLATE_REPO
}
if (-not $TemplateRepo) {
    Err @"
WORKFLOW_TEMPLATE_REPO is not set.

Run this once in PowerShell to set it permanently:

  [System.Environment]::SetEnvironmentVariable(
    'WORKFLOW_TEMPLATE_REPO',
    'https://github.com/YOUR_USERNAME/ai-workflow-template.git',
    'User'
  )

Then restart your terminal and try again.
"@
}

# ── Git check ─────────────────────────────────────────────────────────────────
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Err "git is not found in PATH. Install Git for Windows from https://git-scm.com/download/win"
}

# ── Project name ──────────────────────────────────────────────────────────────
if (-not $Name) {
    $Name = Split-Path -Leaf (Get-Location)
    Log "No -Name provided. Using current directory name: '$Name'"
}

$Date = Get-Date -Format "yyyy-MM-dd"

# ── Template cache ────────────────────────────────────────────────────────────
$CacheDir = Join-Path $env:LOCALAPPDATA "workflow-template-cache"

Log "Syncing template from $TemplateRepo ..."

if (Test-Path (Join-Path $CacheDir ".git")) {
    Log "Updating cached template..."
    try {
        git -C $CacheDir pull --quiet 2>&1 | Out-Null
        Log "Template cache updated."
    } catch {
        Warn "Could not pull latest template. Using cached version."
    }
} else {
    Log "Cloning template repo (first time)..."
    New-Item -ItemType Directory -Force -Path $CacheDir | Out-Null
    Remove-Item -Recurse -Force $CacheDir
    git clone --quiet $TemplateRepo $CacheDir
    if ($LASTEXITCODE -ne 0) {
        Err "Failed to clone template repo. Check WORKFLOW_TEMPLATE_REPO and your network."
    }
    Log "Template cloned successfully."
}

# ── Safety check ──────────────────────────────────────────────────────────────
$Target = ".workflow"
if (Test-Path $Target) {
    Err ".workflow\ already exists in this directory.
If you want to reinitialize:
  Remove-Item -Recurse -Force .workflow
  .\init.ps1 -Type $Type -Domain $Domain"
}

# ── Scaffold ──────────────────────────────────────────────────────────────────
Log "Scaffolding .workflow\ (Type=$Type, Domain=$Domain) ..."

$TemplateSrc = Join-Path $CacheDir "template\.workflow"

# Core files
New-Item -ItemType Directory -Force -Path $Target | Out-Null

Copy-Item (Join-Path $TemplateSrc "AGENTS.md")   $Target
Copy-Item -Recurse (Join-Path $TemplateSrc "memory")    $Target
Copy-Item -Recurse (Join-Path $TemplateSrc "decisions") $Target
Copy-Item -Recurse (Join-Path $TemplateSrc "templates") $Target

# Session file
Copy-Item (Join-Path $TemplateSrc "templates\session_template.md") (Join-Path $Target "session.md")

# Stage files — type-specific only
New-Item -ItemType Directory -Force -Path (Join-Path $Target "stages") | Out-Null
Copy-Item -Recurse (Join-Path $TemplateSrc "stages\$Type") (Join-Path $Target "stages\$Type")
Log "Stages copied: $Type"

# ML branch
if ($Domain -eq "ml") {
    Copy-Item -Recurse (Join-Path $TemplateSrc "stages\ml_branch") (Join-Path $Target "stages\ml_branch")
    Log "ML branch stages added."
}

# ── Substitute placeholders ───────────────────────────────────────────────────
Log "Injecting project metadata..."

Get-ChildItem -Path $Target -Recurse -Include "*.md","*.json" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace "\{\{PROJECT_NAME\}\}", $Name
    $content = $content -replace "\{\{TYPE\}\}",         $Type
    $content = $content -replace "\{\{DOMAIN\}\}",       $Domain
    $content = $content -replace "\{\{DATE\}\}",         $Date
    $content = $content -replace "\{\{VERSION\}\}",      $SCRIPT_VERSION
    Set-Content $_.FullName $content -NoNewline
}

# ── Done ──────────────────────────────────────────────────────────────────────
Write-Host ""
Log "✓ Workflow initialized."
Write-Host ""
Write-Host "  Project : $Name"
Write-Host "  Type    : $Type"
Write-Host "  Domain  : $Domain"
Write-Host "  Date    : $Date"
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "  Next steps"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""
Write-Host "  1. Open VS Code in this directory"
Write-Host "  2. Start Claude Code"
Write-Host "  3. Say exactly:"
Write-Host ""
Write-Host '     "Read .workflow/AGENTS.md and .workflow/session.md.'
Write-Host '      Tell me what you loaded, your confidence level,'
Write-Host '      and the current task. Then let''s begin."'
Write-Host ""
Write-Host "  4. Work through stages in: .workflow\stages\$Type\"
if ($Domain -eq "ml") {
    Write-Host "     ML stages also in: .workflow\stages\ml_branch\"
}
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
