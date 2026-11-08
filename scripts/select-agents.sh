#!/usr/bin/env bash
# ==============================================================================
# divide-and-conquer-dev-plugin — Agency Roster Selector (msitarzewski/agency-agents)
# Enables users to browse, search, and install any of the 283 agents across all
# 18 divisions from https://github.com/msitarzewski/agency-agents
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CATALOG_DIR="$PLUGIN_ROOT/agents/agency-catalog"
RAW_DIR="$CATALOG_DIR/raw-agents"
SKILLS_DIR="$CATALOG_DIR/antigravity-skills"

# Gate 0 check: Ensure git and gh exist before running plugin tooling
"$SCRIPT_DIR/preflight-check.sh" --quiet --skip-auth

TARGET_DIR="$(pwd)"
ACTION=""
DIVISIONS_CSV=""
AGENTS_CSV=""
SEARCH_TERM=""

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Select and enable specialist AI agents from https://github.com/msitarzewski/agency-agents
(All 18 divisions / 283 specialist agents bundled).

Options:
  --list-divisions              List all 18 divisions and agent counts
  --list-agents [DIVISION]      List available agents (optionally filtered by division)
  --search <KEYWORD>            Search agents by name, division, or description
  --divisions <d1,d2,...>       Enable all agents in the comma-separated divisions
  --agents <a1,a2,...>          Enable specific agents by slug (with or without 'agency-' prefix)
  --all                         Enable all 283 agents across all 18 divisions
  --target <DIR>                Target workspace root (default: current directory)
  -h, --help                    Show this help message

Examples:
  $(basename "$0") --list-divisions
  $(basename "$0") --search "security"
  $(basename "$0") --divisions engineering,security,testing --target /path/to/project
  $(basename "$0") --agents backend-architect,frontend-developer,api-tester --target .
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --list-divisions) ACTION="list-divisions"; shift ;;
    --list-agents)
      ACTION="list-agents"
      if [[ $# -gt 1 && ! "$2" =~ ^-- ]]; then
        DIVISIONS_CSV="$2"; shift 2
      else
        shift
      fi
      ;;
    --search) ACTION="search"; SEARCH_TERM="$2"; shift 2 ;;
    --divisions) ACTION="install-divisions"; DIVISIONS_CSV="$2"; shift 2 ;;
    --agents) ACTION="install-agents"; AGENTS_CSV="$2"; shift 2 ;;
    --all) ACTION="install-all"; shift ;;
    --target) TARGET_DIR="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$ACTION" ]]; then
  usage
  exit 0
fi

install_single_skill() {
  local slug="$1"
  local clean_slug="${slug#agency-}"
  local skill_src="$SKILLS_DIR/agency-$clean_slug"

  if [[ ! -d "$skill_src" ]]; then
    echo "  ⚠️  Agent skill not found: $slug (expected $skill_src)" >&2
    return 1
  fi

  mkdir -p "$TARGET_DIR/.agents/skills/agency-$clean_slug"
  cp -r "$skill_src/"* "$TARGET_DIR/.agents/skills/agency-$clean_slug/"

  # Also copy raw agent markdown if found across divisions
  local raw_file
  raw_file="$(find "$RAW_DIR" -name "*${clean_slug}*.md" | head -n 1 || true)"
  if [[ -n "$raw_file" ]]; then
    mkdir -p "$TARGET_DIR/.agents/agents"
    cp "$raw_file" "$TARGET_DIR/.agents/agents/"
  fi
}

case "$ACTION" in
  list-divisions)
    echo "======================================================================"
    echo "  Bundled Agency-Agents Divisions (msitarzewski/agency-agents)"
    echo "======================================================================"
    printf "  %-24s | %-12s\n" "DIVISION" "AGENT COUNT"
    echo "----------------------------------------------------------------------"
    total=0
    for div_path in "$RAW_DIR"/*; do
      if [[ -d "$div_path" ]]; then
        div_name="$(basename "$div_path")"
        count="$(find "$div_path" -name "*.md" | wc -l)"
        total=$((total + count))
        printf "  %-24s | %4d agents\n" "$div_name" "$count"
      fi
    done
    echo "----------------------------------------------------------------------"
    printf "  %-24s | %4d converted Antigravity skills\n" "TOTAL" "$(ls -1d "$SKILLS_DIR"/agency-* | wc -l)"
    ;;

  list-agents)
    if [[ -n "$DIVISIONS_CSV" ]]; then
      IFS=',' read -ra DIVS <<< "$DIVISIONS_CSV"
      for div in "${DIVS[@]}"; do
        echo "=== Division: $div ==="
        find "$RAW_DIR/$div" -name "*.md" -exec basename {} .md \; | sort | sed 's/^/  - /'
      done
    else
      ls -1d "$SKILLS_DIR"/agency-* | xargs -n1 basename | sed 's/^agency-//' | sort
    fi
    ;;

  search)
    echo "🔎 Searching 283 agency-agents for '$SEARCH_TERM'..."
    grep -ri -l "$SEARCH_TERM" "$SKILLS_DIR"/agency-*/SKILL.md | while read -r match; do
      skill_dir="$(dirname "$match")"
      slug="$(basename "$skill_dir" | sed 's/^agency-//')"
      desc="$(grep -m1 '^description:' "$match" | sed 's/^description:[[:space:]]*//')"
      printf "  • %-36s — %s\n" "$slug" "$desc"
    done
    ;;

  install-divisions)
    IFS=',' read -ra DIVS <<< "$DIVISIONS_CSV"
    installed=0
    mkdir -p "$TARGET_DIR/.agents/agents" "$TARGET_DIR/.agents/skills"
    for div in "${DIVS[@]}"; do
      if [[ ! -d "$RAW_DIR/$div" ]]; then
        echo "⚠️  Unknown division: $div" >&2
        continue
      fi
      echo "📦 Enabling division '$div' into $TARGET_DIR/.agents/..."
      while IFS= read -r md_file; do
        cp "$md_file" "$TARGET_DIR/.agents/agents/"
        base="$(basename "$md_file" .md)"
        # Match corresponding antigravity skill
        stripped="${base#${div}-}"
        if [[ -d "$SKILLS_DIR/agency-$stripped" ]]; then
          cp -r "$SKILLS_DIR/agency-$stripped" "$TARGET_DIR/.agents/skills/"
        elif [[ -d "$SKILLS_DIR/agency-$base" ]]; then
          cp -r "$SKILLS_DIR/agency-$base" "$TARGET_DIR/.agents/skills/"
        fi
        installed=$((installed + 1))
      done < <(find "$RAW_DIR/$div" -name "*.md")
    done
    echo "✅ Enabled $installed agents into $TARGET_DIR/.agents/"
    ;;

  install-agents)
    IFS=',' read -ra SLUGS <<< "$AGENTS_CSV"
    installed=0
    for slug in "${SLUGS[@]}"; do
      if install_single_skill "$slug"; then
        echo "  ✅ Enabled agent: ${slug#agency-}"
        installed=$((installed + 1))
      fi
    done
    echo "✅ Enabled $installed selected agents into $TARGET_DIR/.agents/"
    ;;

  install-all)
    echo "📦 Enabling ALL 283 agents across all 18 divisions into $TARGET_DIR/.agents/..."
    mkdir -p "$TARGET_DIR/.agents/skills" "$TARGET_DIR/.agents/agents"
    cp -r "$SKILLS_DIR"/agency-* "$TARGET_DIR/.agents/skills/"
    find "$RAW_DIR" -name "*.md" -exec cp {} "$TARGET_DIR/.agents/agents/" \;
    echo "✅ All 283 Antigravity skills and raw agent definitions enabled in $TARGET_DIR/.agents/"
    ;;
esac
