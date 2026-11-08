#!/usr/bin/env bash
# ==============================================================================
# divide-and-conquer-dev-plugin — Universal Tri-Platform Plugin Installer
# Supports Google Antigravity, Claude Code, and OpenAI Codex CLI.
# Enforces Gate 0 (git + gh verification) before installing the plugin, skills,
# slash commands, core orchestrators, and selected msitarzewski/agency-agents.
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

TARGET_DIR="$(pwd)"
TOOL_PLATFORM="all"
DIVISIONS_CSV="engineering,security,testing"
AGENTS_CSV=""
INSTALL_ALL_AGENTS=false
SKIP_AUTH=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Install the divide-and-conquer-dev-plugin into a target project workspace for:
  • Google Antigravity (.agents/, AGENTS.md)
  • Claude Code        (.claude/, CLAUDE.md, commands/, agents/, skills/)
  • OpenAI Codex CLI   (.codex/, AGENTS.md, skills/)

Verifies that both 'git' and 'gh' are installed before starting installation.

Options:
  --target <DIR>              Target project workspace directory (default: current directory)
  --tool <PLATFORM>           Target platform: antigravity | claude | codex | all (default: all)
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
    --tool) TOOL_PLATFORM="$2"; shift 2 ;;
    --divisions) DIVISIONS_CSV="$2"; shift 2 ;;
    --agents) AGENTS_CSV="$2"; shift 2 ;;
    --all-agents) INSTALL_ALL_AGENTS=true; shift ;;
    --skip-auth) SKIP_AUTH=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

echo "======================================================================"
echo "  Installing divide-and-conquer-dev-plugin (Platform: $TOOL_PLATFORM)"
echo "======================================================================"

# 1. Mandatory Gate 0 check: Ensure git and gh exist before starting!
if [[ "$SKIP_AUTH" == true ]]; then
  "$SCRIPT_DIR/preflight-check.sh" --skip-auth
else
  "$SCRIPT_DIR/preflight-check.sh"
fi

# 2. Create base directories & install Antigravity / Universal layout (.agents/)
mkdir -p "$TARGET_DIR/.agents/rules" \
         "$TARGET_DIR/.agents/skills" \
         "$TARGET_DIR/.agents/agents" \
         "$TARGET_DIR/.agents/checkpoints" \
         "$TARGET_DIR/scripts" \
         "$TARGET_DIR/.worktrees"

cp "$PLUGIN_ROOT/rules/AGENTS.md" "$TARGET_DIR/AGENTS.md"
cp -r "$PLUGIN_ROOT/rules/references/"* "$TARGET_DIR/.agents/rules/"
cp -r "$PLUGIN_ROOT/skills/"* "$TARGET_DIR/.agents/skills/"
cp "$PLUGIN_ROOT/agents/"*.md "$TARGET_DIR/.agents/agents/"
cp "$PLUGIN_ROOT/scripts/"*.sh "$TARGET_DIR/scripts/"
cp "$PLUGIN_ROOT/hooks.json" "$TARGET_DIR/hooks.json"
mkdir -p "$TARGET_DIR/hooks" && cp "$PLUGIN_ROOT/hooks/hooks.json" "$TARGET_DIR/hooks/hooks.json" 2>/dev/null || true
chmod +x "$TARGET_DIR/scripts/"*.sh

# 3. Enable selected specialist agents from msitarzewski/agency-agents into .agents/
if [[ "$INSTALL_ALL_AGENTS" == true ]]; then
  "$SCRIPT_DIR/select-agents.sh" --all --target "$TARGET_DIR"
elif [[ -n "$AGENTS_CSV" ]]; then
  "$SCRIPT_DIR/select-agents.sh" --agents "$AGENTS_CSV" --target "$TARGET_DIR"
elif [[ -n "$DIVISIONS_CSV" ]]; then
  "$SCRIPT_DIR/select-agents.sh" --divisions "$DIVISIONS_CSV" --target "$TARGET_DIR"
fi

# 4. Claude Code Platform Setup (.claude/ and CLAUDE.md)
if [[ "$TOOL_PLATFORM" == "claude" || "$TOOL_PLATFORM" == "all" ]]; then
  mkdir -p "$TARGET_DIR/.claude/skills" \
           "$TARGET_DIR/.claude/agents" \
           "$TARGET_DIR/.claude/commands"
  cp "$PLUGIN_ROOT/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
  cp -r "$TARGET_DIR/.agents/skills/"* "$TARGET_DIR/.claude/skills/"
  cp -r "$TARGET_DIR/.agents/agents/"* "$TARGET_DIR/.claude/agents/"
  cp -r "$PLUGIN_ROOT/commands/"* "$TARGET_DIR/.claude/commands/"
  echo "  ✅ Configured Claude Code (.claude/skills, .claude/agents, .claude/commands, CLAUDE.md)"
fi

# 5. OpenAI Codex CLI Platform Setup (.codex/ and AGENTS.md)
if [[ "$TOOL_PLATFORM" == "codex" || "$TOOL_PLATFORM" == "all" ]]; then
  mkdir -p "$TARGET_DIR/.codex/skills" \
           "$TARGET_DIR/.codex/agents"
  cp -r "$TARGET_DIR/.agents/skills/"* "$TARGET_DIR/.codex/skills/"
  cp -r "$TARGET_DIR/.agents/agents/"* "$TARGET_DIR/.codex/agents/"
  echo "  ✅ Configured OpenAI Codex CLI (.codex/skills, .codex/agents, AGENTS.md)"
fi

echo ""
echo "✅ divide-and-conquer-dev-plugin installed into: $TARGET_DIR"
echo "   • Antigravity & Codex Rules: $TARGET_DIR/AGENTS.md"
echo "   • Claude Code Rules:         $TARGET_DIR/CLAUDE.md"
echo "   • Reviewing Council Skills:  $TARGET_DIR/.agents/skills/ (includes cloudflare/security-audit-skill)"
echo "   • Core & Agency Roster:      $TARGET_DIR/.agents/agents/"
echo "   • Worktree Sandbox:          $TARGET_DIR/.worktrees/"
echo "======================================================================"
