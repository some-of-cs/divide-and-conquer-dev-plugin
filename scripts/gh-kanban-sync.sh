#!/usr/bin/env bash
# ==============================================================================
# divide-and-conquer-dev-plugin — GitHub Projects v2 Kanban & Checkpoint Sync
# Replaces local KANBAN.md files with GitHub Projects + .agents/checkpoints/
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Gate 0 Preflight: Ensure git and gh exist before running
"$SCRIPT_DIR/preflight-check.sh" --quiet --skip-auth

CMD="${1:-help}"
shift || true

MODULE_ID="module-1"
ITEM_ID=""
STATUS="Todo"
BRANCH=""
WORKTREE=""
PR_NUM=""
SHA=""
TITLE=""
PROJECT_NUMBER="${GH_PROJECT_NUMBER:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --module) MODULE_ID="$2"; shift 2 ;;
    --id) ITEM_ID="$2"; shift 2 ;;
    --status) STATUS="$2"; shift 2 ;;
    --branch) BRANCH="$2"; shift 2 ;;
    --worktree) WORKTREE="$2"; shift 2 ;;
    --pr) PR_NUM="$2"; shift 2 ;;
    --sha) SHA="$2"; shift 2 ;;
    --title) TITLE="$2"; shift 2 ;;
    --project-number) PROJECT_NUMBER="$2"; shift 2 ;;
    *) shift ;;
  esac
done

CHECKPOINT_DIR=".agents/checkpoints/$MODULE_ID"
CHECKPOINT_FILE="$CHECKPOINT_DIR/checkpoint.json"
mkdir -p "$CHECKPOINT_DIR"

NOW="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

case "$CMD" in
  init)
    cat > "$CHECKPOINT_FILE" <<EOF
{
  "moduleId": "$MODULE_ID",
  "title": "${TITLE:-$MODULE_ID}",
  "githubProjectNumber": ${PROJECT_NUMBER:-null},
  "updatedAt": "$NOW",
  "items": {}
}
EOF
    echo "✅ Initialized checkpoint store at $CHECKPOINT_FILE"
    if [[ -n "$PROJECT_NUMBER" ]]; then
      echo "📋 Linked to GitHub Project #$PROJECT_NUMBER"
    fi
    ;;

  status)
    if [[ -z "$ITEM_ID" ]]; then
      echo "ERROR: --id <unit-or-story-id> is required for 'status'" >&2
      exit 1
    fi
    if [[ ! -f "$CHECKPOINT_FILE" ]]; then
      "$0" init --module "$MODULE_ID"
    fi

    python3 - "$CHECKPOINT_FILE" "$ITEM_ID" "$STATUS" "$BRANCH" "$WORKTREE" "$PR_NUM" "$SHA" "$NOW" <<'PY'
import json, sys
path, item_id, status, branch, worktree, pr_num, sha, now = sys.argv[1:]
with open(path, "r", encoding="utf-8") as f:
    data = json.load(f)
items = data.setdefault("items", {})
entry = items.setdefault(item_id, {})
entry["status"] = status
entry["updatedAt"] = now
if branch:
    entry["branch"] = branch
if worktree:
    entry["worktree"] = worktree
if pr_num:
    entry["prNumber"] = int(pr_num)
if sha:
    entry["mergedSha"] = sha
data["updatedAt"] = now
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
PY
    echo "✅ Updated $CHECKPOINT_FILE: [$ITEM_ID] -> $STATUS"

    # If a PR number and GitHub Project Number are configured, sync with GitHub Projects v2
    if [[ -n "$PR_NUM" && -n "$PROJECT_NUMBER" ]]; then
      REPO_URL="$(gh repo view --json url -q .url 2>/dev/null || true)"
      if [[ -n "$REPO_URL" ]]; then
        gh project item-add "$PROJECT_NUMBER" --owner "@me" --url "$REPO_URL/pull/$PR_NUM" >/dev/null 2>&1 || true
        echo "📋 Synced PR #$PR_NUM to GitHub Project #$PROJECT_NUMBER ($STATUS)"
      fi
    fi
    ;;

  *)
    cat <<EOF
Usage:
  $(basename "$0") init --module <module-id> [--title <title>] [--project-number <N>]
  $(basename "$0") status --module <module-id> --id <item-id> --status "<Todo|In Progress|In Review|Merged>" [--branch <b_name>] [--worktree <path>] [--pr <num>] [--sha <sha>]
EOF
    ;;
esac
