# Reference 04: Multi-Council Code Review & Mandatory `patch-implementer` Loop

## 1. Parallel Code Reviewing Councils

Multiple Code Reviewing Councils may run simultaneously across any number of active units, stories, or modules. Each Council is armed with:
- `skills/code-review-council/SKILL.md`
- `skills/security-audit/SKILL.md`
- `skills/cyclomatic-complexity/SKILL.md`
- Any project-specific domain/framework skills selected from `msitarzewski/agency-agents`.

## 2. The Mandatory `patch-implementer` Self-Correction Loop

At the **User Story** and **Module** tiers, leaders coordinate orchestration and **never directly edit production code in their own conversation context** when a Code Reviewing Council flags an issue.

```mermaid
flowchart TD
    A["All K Units Merged into Story Branch (feat/us-M.S.0)"] --> B["Story Leader Runs Story Integration Suite"]
    B --> C["Story Leader Invokes Independent Code Reviewer Council"]
    C --> D{"0 Issues & CC <= 10?"}
    D -- "Yes (100% Clean)" --> E["Council Posts Gate G-Review Approval Comment on Story PR"]
    E --> F["Git Workflow Master Merges Story PR into Module Branch via gh pr merge"]
    D -- "No (Issues Flagged)" --> G["Council Posts Findings Comment on Story PR Conversation"]
    G --> H["Story Leader Spawns Dedicated patch-implementer Subagent"]
    H --> I["patch-implementer Fixes Issues in .worktrees/patch-us-M.S.0-<scope>"]
    I --> J["Git Workflow Master Opens Patch PR & Merges into Story Branch"]
    J --> B
```

### Why `patch-implementer` Is Mandatory
1. **Context Purity**: Keeps Story and Module Leaders lightweight and focused on orchestration rather than filling their context windows with file diffs and compiler output.
2. **Full Auditability**: Every post-merge remediation is isolated in its own atomic `patch/*` branch and PR with a dedicated in-PR report and review sign-off.
3. **Zero Silent Edits**: Prevents unreviewed ad-hoc commits from being pushed directly onto story or module branches after unit reviews have completed.
