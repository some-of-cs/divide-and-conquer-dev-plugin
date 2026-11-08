#!/usr/bin/env bash
# ==============================================================================
# divide-and-conqure-dev-plugin — Workspace & Global Plugin Installer
# Enforces Gate 0 (git + gh verification) before installing the plugin, skills,
# core orchestrators, and selected msitarzewski/agency-agents into a project.
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

TARGET_DIR="$(pwd)"
DIVISIONS_CSV="engineering,security,testing"
AGENTS_CSV=""
INSTALL_ALL_AGENTS=false
SKIP_AUTH=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Install the divide-and-conqure-dev-plugin into a target project workspace.
Verifies that both 'git' and 'gh' are installed before starting installation.

Options:
  --target <DIR>              Target project workspace directory (default: current directory)
  --divisions <d1,d2,...>     Agency-Agents divisions to enable (default: engineering,security,testing)
  --agents <a1,a2,...>        Specific Agency-Agents slugs to enable
  --all-agents                Enable all 283 agents across all 18 divisions
  --skip-auth                 Skip 'gh auth status' check during offline CI/testing
  -h, --help                  Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) TARGET_DIR="$2"; shift 2 ;;
    --divisions) DIVISIONS_CSV="$2"; shift 2 ;;
    --agents) AGENTS_CSV="$2"; shift 2 ;;
    --all-agents) INSTALL_ALL_AGENTS=true; shift ;;
    --skip-auth) SKIP_AUTH=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

echo "======================================================================"
echo "  Installing divide-and-conqure-dev-plugin"
echo "======================================================================"

# 1. Mandatory Gate 0 check: Ensure git and gh exist before starting!
if [[ "$SKIP_AUTH" == true ]]; then
  "$SCRIPT_DIR/preflight-check.sh" --skip-auth
else
  "$SCRIPT_DIR/preflight-check.sh"
fi

# 2. Create target structure
mkdir -p "$TARGET_DIR/.agents/rules" \
         "$TARGET_DIR/.agents/skills" \
         "$TARGET_DIR/.agents/agents" \
         "$TARGET_DIR/.agents/checkpoints" \
         "$TARGET_DIR/scripts" \
         "$TARGET_DIR/.worktrees"

# 3. Copy core rules, skills, core agents, and helper scripts
cp "$PLUGIN_ROOT/rules/AGENTS.md" "$TARGET_DIR/AGENTS.md"
cp -r "$PLUGIN_ROOT/rules/references/"* "$TARGET_DIR/.agents/rules/"
cp -r "$PLUGIN_ROOT/skills/"* "$TARGET_DIR/.agents/skills/"
cp -r "$PLUGIN_ROOT/agents/core/"* "$TARGET_DIR/.agents/agents/"
cp "$PLUGIN_ROOT/scripts/"*.sh "$TARGET_DIR/scripts/"
chmod +x "$TARGET_DIR/scripts/"*.sh

# 4. Enable selected specialist agents from msitarzewski/agency-agents
if [[ "$INSTALL_ALL_AGENTS" == true ]]; then
  "$SCRIPT_DIR/select-agents.sh" --all --target "$TARGET_DIR"
elif [[ -n "$AGENTS_CSV" ]]; then
  "$SCRIPT_DIR/select-agents.sh" --agents "$AGENTS_CSV" --target "$TARGET_DIR"
elif [[ -n "$DIVISIONS_CSV" ]]; then
  "$SCRIPT_DIR/select-agents.sh" --divisions "$DIVISIONS_CSV" --target "$TARGET_DIR"
fi

echo ""
echo "✅ divide-and-conqure-dev-plugin installed into: $TARGET_DIR"
echo "   • Core Rules:        $TARGET_DIR/AGENTS.md"
echo "   • Council Skills:    $TARGET_DIR/.agents/skills/"
echo "   • Core & Agency:     $TARGET_DIR/.agents/agents/"
echo "   • Worktree Sandbox:  $TARGET_DIR/.worktrees/"
echo "======================================================================"
