#!/usr/bin/env bash
# =============================================================================
# workflow-init — AI-assisted development workflow scaffolder
# Usage: workflow-init --type <greenfield|brownfield> --domain <ml|general> [--name <project-name>]
# Requires: WORKFLOW_TEMPLATE_REPO env var pointing to your GitHub template repo
# =============================================================================
set -euo pipefail

# ── Constants ─────────────────────────────────────────────────────────────────
TEMPLATE_CACHE="$HOME/.cache/workflow-template"
LOG_PREFIX="[workflow-init]"
SCRIPT_VERSION="1.0.0"

# ── Helpers ───────────────────────────────────────────────────────────────────
log()  { echo "$LOG_PREFIX $*"; }
warn() { echo "$LOG_PREFIX WARN: $*" >&2; }
err()  { echo "$LOG_PREFIX ERROR: $*" >&2; exit 1; }

usage() {
  cat <<EOF
Usage: workflow-init --type <greenfield|brownfield> --domain <ml|general> [--name <project-name>]

Options:
  --type    greenfield  Start from scratch (problem → requirements → architecture → build)
            brownfield  Work on existing code (understand → blast radius → change → validate)
  --domain  ml          Machine learning / AI project (adds eval criteria, experiment log)
            general     General application (web app, CLI tool, service, etc.)
  --name    Optional. Project name used in file headers. Defaults to current directory name.

Environment:
  WORKFLOW_TEMPLATE_REPO  GitHub URL of your ai-workflow-template repo (required)

Examples:
  workflow-init --type greenfield --domain ml
  workflow-init --type brownfield --domain general --name network-agent
EOF
  exit 1
}

# ── Argument parsing ──────────────────────────────────────────────────────────
TYPE=""
DOMAIN=""
PROJECT_NAME=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --type)    TYPE="$2";         shift 2 ;;
    --domain)  DOMAIN="$2";       shift 2 ;;
    --name)    PROJECT_NAME="$2"; shift 2 ;;
    --help|-h) usage ;;
    *)         err "Unknown argument: $1. Run with --help for usage." ;;
  esac
done

# ── Validation ────────────────────────────────────────────────────────────────
[[ -z "$TYPE" || -z "$DOMAIN" ]] && usage

[[ "$TYPE" != "greenfield" && "$TYPE" != "brownfield" ]] \
  && err "Invalid --type '$TYPE'. Must be 'greenfield' or 'brownfield'."

[[ "$DOMAIN" != "ml" && "$DOMAIN" != "general" ]] \
  && err "Invalid --domain '$DOMAIN'. Must be 'ml' or 'general'."

[[ -z "${WORKFLOW_TEMPLATE_REPO:-}" ]] \
  && err "WORKFLOW_TEMPLATE_REPO is not set. Add this to your ~/.bashrc or ~/.zshrc:
  export WORKFLOW_TEMPLATE_REPO='https://github.com/YOUR_USERNAME/ai-workflow-template.git'"

# ── Project name ──────────────────────────────────────────────────────────────
if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME=$(basename "$(pwd)")
  log "No --name provided. Using directory name: '$PROJECT_NAME'"
fi

DATE=$(date +%Y-%m-%d)

# ── Pull / update template cache ──────────────────────────────────────────────
log "Syncing template from $WORKFLOW_TEMPLATE_REPO ..."

if [[ -d "$TEMPLATE_CACHE/.git" ]]; then
  log "Updating cached template..."
  if git -C "$TEMPLATE_CACHE" pull --quiet 2>&1; then
    log "Template cache updated."
  else
    warn "Could not pull latest template. Using cached version."
  fi
else
  log "Cloning template repo (first time, may take a moment)..."
  mkdir -p "$(dirname "$TEMPLATE_CACHE")"
  git clone --quiet "$WORKFLOW_TEMPLATE_REPO" "$TEMPLATE_CACHE" \
    || err "Failed to clone template repo. Check WORKFLOW_TEMPLATE_REPO and your network."
  log "Template cloned successfully."
fi

# ── Safety check ─────────────────────────────────────────────────────────────
TARGET=".workflow"
if [[ -d "$TARGET" ]]; then
  err ".workflow/ already exists in this directory.
  If you want to reinitialize: rm -rf .workflow && workflow-init ..."
fi

# ── Scaffold structure ────────────────────────────────────────────────────────
log "Scaffolding .workflow/ (type=$TYPE, domain=$DOMAIN) ..."

# Core files
cp -r "$TEMPLATE_CACHE/template/.workflow/AGENTS.md"  "$TARGET/" 2>/dev/null \
  || err "Template missing AGENTS.md. Check your template repo."
cp -r "$TEMPLATE_CACHE/template/.workflow/memory"     "$TARGET/"
cp -r "$TEMPLATE_CACHE/template/.workflow/decisions"  "$TARGET/"
cp -r "$TEMPLATE_CACHE/template/.workflow/templates"  "$TARGET/"

# Session file (from template)
cp "$TEMPLATE_CACHE/template/.workflow/templates/session_template.md" "$TARGET/session.md"

# Stage files — only the relevant type
mkdir -p "$TARGET/stages"
cp -r "$TEMPLATE_CACHE/template/.workflow/stages/$TYPE" "$TARGET/stages/"
log "Stages copied: $TYPE"

# ML branch — appended if domain is ml
if [[ "$DOMAIN" == "ml" ]]; then
  cp -r "$TEMPLATE_CACHE/template/.workflow/stages/ml_branch" "$TARGET/stages/"
  log "ML branch stages added."
fi

# ── Substitute placeholders ───────────────────────────────────────────────────
log "Injecting project metadata..."

find "$TARGET" -type f -name "*.md" -o -name "*.json" | while read -r f; do
  sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$f"
  sed -i "s/{{TYPE}}/$TYPE/g"                 "$f"
  sed -i "s/{{DOMAIN}}/$DOMAIN/g"             "$f"
  sed -i "s/{{DATE}}/$DATE/g"                 "$f"
  sed -i "s/{{VERSION}}/$SCRIPT_VERSION/g"    "$f"
done

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
log "✓ Workflow initialized."
echo ""
echo "  Project : $PROJECT_NAME"
echo "  Type    : $TYPE"
echo "  Domain  : $DOMAIN"
echo "  Date    : $DATE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Next steps"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  1. Open VS Code in this directory"
echo "  2. Start Claude Code"
echo "  3. Say exactly:"
echo ""
echo '     "Read .workflow/AGENTS.md and .workflow/session.md.'
echo '      Tell me what you loaded, your confidence level,'
echo '      and the current task. Then let'\''s begin."'
echo ""
echo "  4. Work through stages in: .workflow/stages/$TYPE/"
if [[ "$DOMAIN" == "ml" ]]; then
  echo "     ML stages also available in: .workflow/stages/ml_branch/"
fi
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
