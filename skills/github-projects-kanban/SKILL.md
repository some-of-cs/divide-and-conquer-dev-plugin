---
name: github-projects-kanban
description: Manage visual Kanban development status via GitHub Projects (gh project), synchronize local .agents/checkpoints/checkpoint.json for idempotent recovery, and post all execution/review reports directly into GitHub PR conversations.
---

# GitHub Projects Kanban & In-PR Reporting Skill

This plugin eliminates merge-conflict-prone local `KANBAN.md` files and local `.agents/reports/` files. Instead:
1. **Visual Kanban Status** lives in **GitHub Projects v2** (`gh project`) synchronized with `.agents/checkpoints/<module-id>/checkpoint.json`.
2. **All Execution, Security, Complexity, and Review Reports** live directly inside **GitHub Pull Request conversations** (`gh pr comment`).

---

## 1. Visual Kanban Management with GitHub Projects (`gh project`)

### Kanban Columns
Every Module, User Story, Implementation Unit ($1..K$), and Patch (`patch/*`) transitions through 4 states:
1. **`Todo`** — Planned during `spec-decomposition`.
2. **`In Progress`** — Worktree created in `.worktrees/` and agent spawned.
3. **`In Review / PR Open`** — PR created (`gh pr create`), Implementation Report posted, and Code Reviewing Council active.
4. **`Merged`** — Council `Gate G-Review` approved and PR merged via `gh pr merge`.

### CLI Commands (`scripts/gh-kanban-sync.sh`)

```bash
# 1. Initialize or link a GitHub Project for the repository and create checkpoint.json
./scripts/gh-kanban-sync.sh init --module module-1 --title "Module 1: Core Runtime"

# 2. Transition a Unit or Story to "In Progress" when its worktree is provisioned
./scripts/gh-kanban-sync.sh status \
  --module module-1 \
  --id "us-1.1.0/unit-1" \
  --status "In Progress" \
  --worktree ".worktrees/feat-us-1.1.0-unit-1-transport" \
  --branch "feat/us-1.1.0/unit-1-transport"

# 3. Transition to "In Review / PR Open" when the PR is opened
./scripts/gh-kanban-sync.sh status \
  --module module-1 \
  --id "us-1.1.0/unit-1" \
  --status "In Review" \
  --pr 42

# 4. Transition to "Merged" after Council sign-off and gh pr merge
./scripts/gh-kanban-sync.sh status \
  --module module-1 \
  --id "us-1.1.0/unit-1" \
  --status "Merged" \
  --pr 42 \
  --sha "$(git rev-parse HEAD)"
```

---

## 2. Local Checkpoint Store (`.agents/checkpoints/<module-id>/checkpoint.json`)

While GitHub Projects provides the visual Kanban board for humans, `.agents/checkpoints/<module-id>/checkpoint.json` provides sub-millisecond local state lookup for agents and `quota-sentinel` recovery:

```json
{
  "moduleId": "module-1",
  "githubProjectNumber": 1,
  "updatedAt": "2026-11-08T09:30:00Z",
  "stories": {
    "us-1.1.0": {
      "status": "In Progress",
      "branch": "feat/us-1.1.0-core-transport",
      "unitCount": 3,
      "units": {
        "unit-1": {
          "status": "Merged",
          "branch": "feat/us-1.1.0/unit-1-http-client",
          "prNumber": 12,
          "mergedSha": "a1b2c3d"
        },
        "unit-2": {
          "status": "In Review",
          "branch": "feat/us-1.1.0/unit-2-retry-engine",
          "prNumber": 13,
          "mergedSha": null
        },
        "unit-3": {
          "status": "In Progress",
          "branch": "feat/us-1.1.0/unit-3-error-types",
          "prNumber": null,
          "mergedSha": null
        }
      }
    }
  }
}
```

---

## 3. Posting Reports Directly to PR Conversations (`scripts/post-pr-report.sh`)

Never write local markdown reports to `.agents/reports/`. Always attach reports directly to the PR conversation:

```bash
# Post an Implementation Report from a Unit Implementer, Patch Implementer, or Leader
./scripts/post-pr-report.sh implementation \
  --pr 12 \
  --role "Unit 1 Implementer (US-1.1.0)" \
  --scope "HTTP Transport & Connection Pool" \
  --files "src/transport.ts,tests/transport.test.ts" \
  --test-cmd "npm test && npm run lint" \
  --test-output "24 passed, 0 warnings"

# Post a Code Reviewing Council Report (Security Audit + Cyclomatic Complexity + Verdict)
./scripts/post-pr-report.sh review \
  --pr 12 \
  --verdict "APPROVED" \
  --max-cc 5 \
  --security-summary "0 vulnerabilities, constant-time token check verified" \
  --coverage "94.2% lines, 88.5% branches"
```
