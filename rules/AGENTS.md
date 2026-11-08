# Divide-and-Conquer Development Plugin — Workspace Agent Rules (`AGENTS.md`)

Welcome to the **`divide-and-conquer-dev-plugin`** governance engine for **Google Antigravity**. Every AI agent, subagent, leader, implementer, and reviewing council operating in a workspace powered by this plugin MUST strictly obey these invariants.

> [!IMPORTANT]
> **Model & Token Profile**: This plugin is engineered to produce **zero-debt, production-grade software** through massive parallelism, multi-council code review, and automated self-correction loops. Because this architecture spawns concurrent subagents and iterative review councils, it **consumes a high volume of tokens** and is **primarily designed and optimized for the Gemini Flash family** (e.g., `gemini-2.5-flash` / `gemini-3-flash`). It operates on a **single profile at a time** protected by an autonomous `quota-sentinel`.

---

## Rule 0: Mandatory `git` & `gh` Preflight Gate (Hard Blocker Before Starting)

1. **Zero Execution Without `git` and `gh`**:
   - Before decomposing any specification, creating worktrees, or spawning any subagent, the Main Agent MUST verify that both **`git`** (with `git worktree` support) and **`gh`** (GitHub CLI, authenticated via `gh auth status`) are installed and available on `$PATH`.
   - Run `./scripts/preflight-check.sh` (automatically triggered by the `SessionStart` hook in `hooks.json`).
   - If `git` is missing, `gh` is missing, or `gh auth status` fails, the agent MUST immediately **STOP** and instruct the user to install/authenticate `git` and `gh` before proceeding.

---

## Rule 1: Monolithic Docs $\to$ Modules $\to$ User Stories $\to$ Dynamic $K$-Unit Decomposition

1. **Four-Level Decomposition Hierarchy**:
   - **Level 0 (Monolithic Input)**: Architecture RFCs, PRD documents, API specifications, or research docs.
   - **Level 1 (Modules — `module-M`)**: Bounded contexts or architectural subsystems (e.g., Core Runtime, Auth, Billing, UI). Branch: `feat/module-M-<slug>`.
   - **Level 2 (User Stories — `us-M.S.0`)**: Cohesive feature deliverables within a module. Branch: `feat/us-M.S.0-<slug>`.
   - **Level 3 (Implementation Units — `unit-1..K`)**: Atomic, self-contained vertical implementation slices with their own unit tests. Branch: `feat/us-M.S.0/unit-N-<slug>`.
2. **Dynamic Implementation Unit Sizing Matrix ($K \in [1, N]$, Not Fixed at 5)**:
   - The number of implementation units per User Story is **dynamically determined** using the `spec-decomposition` skill's **Unit Sizing Decision Matrix** based on:
     1. Distinct domain entities / components / endpoints ($E$)
     2. Estimated lines of code ($L$, targeting $150 \le L_{\text{unit}} \le 400$ LOC per unit)
     3. Cyclomatic complexity & branching density
     4. Orthogonal file/module boundaries
   - A small story may decompose into **2 or 3 units**; a medium story into **4 or 5 units**; a large subsystem story into **6 to 8+ units**.
3. **Pure-Implementation & Non-Blocking Unit Invariant**:
   - **Implementation Only**: Every unit MUST implement real production functionality alongside its own unit/component tests. **Never create a "validation-only", "test-only", or "integration-only" unit** that waits on other units to finish before it can start.
   - **Zero Inter-Unit Blocking**: Units $1..K$ within a User Story MUST be designed with orthogonal file/module boundaries or shared trait/interface contracts so that **all $K$ Unit Implementers execute 100% in parallel** without blocking one another.

---

## Rule 2: Mandatory `.worktrees/` Isolation & Parallel Execution

1. **Strict `.worktrees/` Directory Invariant**:
   - All code modifications, builds, and test executions MUST take place inside `.worktrees/<branch-sanitized-name>` at the repository root. Direct code editing on `main` or in the root working tree is strictly prohibited.
   - Worktrees are provisioned and pruned exclusively by **`Git Workflow Master`**.
2. **Full Parallelism Across Tiers**:
   - All Unit Implementers ($1..K$) for a User Story are spawned simultaneously in separate `.worktrees/` and implement their vertical slices in parallel.
   - Multiple User Story Leaders and multiple **Code Reviewing Councils** run concurrently in parallel.
3. **Shared Build Cache Optimization**:
   - When the project toolchain supports shared build caches across worktrees (e.g., `CARGO_TARGET_DIR`, `TURBO_CACHE_DIR`, `GRADLE_USER_HOME`, `PIP_CACHE_DIR`, `GOMODCACHE`), export the shared cache path inside every worktree to avoid redundant compilation.

---

## Rule 3: Strict 3-Tier Hierarchical Delegation & Watchdog Schedules

1. **Zero Cross-Tier Spawning**:
   - **Main Supervisor**: Spawns and supervises **Module Leaders** and the End-of-Module Whole-Codebase Reviewing Council.
   - **Module Leader (`module-M`)**: Immediately spawns and supervises **User Story Leaders** (`US-M.1.0`, `US-M.2.0`, ...) in its very first step. **Module Leaders MUST NEVER spawn Unit Implementers directly.**
   - **User Story Leader (`us-M.S.0`)**: Immediately spawns and supervises its **$K$ Unit Implementers** (`unit-1..K`) in its very first step.
2. **Zero Idle Talk Before Spawning**:
   - Leaders must spawn their child subagents immediately in step 1 without protracted monologues.
3. **Hierarchical Supervision Schedules**:
   - **Main Supervisor**: Runs a 3-minute watchdog (`schedule` cron `*/3 * * * *`) to monitor Module/Story Leaders and intervene if any leader idles for $>3$ minutes without spawning its children.
   - **Module Leader**: Maintains a 3-minute supervision schedule (`*/3 * * * *`) to coordinate Story Leaders, PR queues, and cascading merges.
   - **Story Leader**: Maintains a 1-minute supervision schedule (`* * * * *`) to track active Unit Implementers, `patch-implementer` runs, and parallel Code Reviewing Councils.

---

## Rule 4: Parallel Multi-Council Code Review & Mandatory `patch-implementer` Loop

1. **Language-Agnostic Federated Gatekeeper Council (Zero Self-Approval)**:
   - No PR at any tier (Unit, Story, Patch, or Module) may be merged via `gh pr merge` without an independent **Code Reviewing Council** sign-off posted to the PR conversation. Self-approval by the authoring agent is strictly forbidden.
   - Multiple Code Reviewing Councils can and should be invoked in parallel across concurrent units and stories.
   - Every Council evaluates:
     - **Gate G0 (Build, Linter & Formatter)**: 0 compiler/interpreter errors, 0 linter warnings, 100% formatter compliance.
     - **Gate G1 (Test Coverage & Contract Validation)**: $\ge 90\%$ line and $\ge 85\%$ branch coverage in affected modules.
     - **Gate G2 (Security Audit — `security-audit` skill)**: OWASP/CWE vulnerability scan, secret hygiene, constant-time crypto where applicable, input bounds.
     - **Gate G-Complexity (`cyclomatic-complexity` skill)**: Target $CC \le 6$, acceptable ceiling $CC \le 10$, **hard merge blocker at $CC > 15$**, max nesting depth $\le 2$.
     - **Gate G-Docs**: Public API docstrings, runnable examples/doctests, and module `README.md`.
     - **Gate G-Review (Council President Sign-Off)**: Formal approval comment posted to the GitHub PR conversation.
2. **3-Tier Iterative Review & `patch-implementer` Self-Correction Loop (Never Terminate Until Clean)**:
   - **Tier 1 — Unit Level**: Upon finishing implementation, each Unit Implementer invokes its own `Code Reviewer` council (with `security-audit` and `cyclomatic-complexity`). If issues or $CC > 10$ are flagged, the Unit Implementer fixes them and re-invokes the reviewer until 0 issues remain. **A Unit Implementer NEVER terminates until its Code Reviewer confirms 100% clean sign-off.**
   - **Tier 2 — User Story Level & Mandatory `patch-implementer` Invariant**: After all $K$ units are merged into the story branch (`feat/us-M.S.0-<slug>`), the Story Leader runs story-wide integration tests and invokes a fresh Story-level `Code Reviewer` council.
     - **Story-Level `patch-implementer` Rule**: If ANY code review, security, complexity, or integration issue is flagged at the story level, the **Story Leader MUST NOT fix the code directly in its own context**. Instead, the Story Leader MUST spawn a dedicated **`patch-implementer`** subagent in an isolated worktree on branch `patch/us-M.S.0-<scope>`, open a patch PR (`fix(us-M.S.0): <summary>`), have it reviewed and merged into the story branch via `gh pr merge`, and **re-invoke the Story `Code Reviewer` council**, repeating this loop until 0 problems remain. **The Story Leader NEVER terminates until the Code Reviewer confirms everything is OK.**
   - **Tier 3 — Module Level & Mandatory `patch-implementer` Invariant**: After all User Stories are merged into the module branch (`feat/module-M-<slug>`), the Module Leader invokes a Module-level `Code Reviewer` council.
     - **Module-Level `patch-implementer` Rule**: If ANY issue is flagged at the module level, the **Module Leader MUST NOT fix it directly**. It MUST spawn a dedicated **`patch-implementer`** subagent on branch `patch/module-M-<scope>`, open a patch PR (`fix(module-M): <summary>`), merge it into the module branch via `gh pr merge`, and re-invoke the Module `Code Reviewer` council until 100% clean sign-off is achieved. **The Module Leader NEVER terminates until the Code Reviewer gives a 100% clean sign-off.**
   - **Tier 4 — End-of-Module Whole-Codebase Validation**: Once the module PR merges into `main`, the Main Supervisor runs full-workspace validation and invokes a Whole-Codebase Gatekeeper Council across Modules $1..M$ to guarantee zero regressions.

---

## Rule 5: Bottom-Up Streaming PR Pipeline & Ordered Cascading Merge (`gh pr merge`)

1. **Strict Naming Conventions**:
   - **Unit Branch**: `feat/us-M.S.0/unit-N-<scope>` | **Unit PR Title**: `feat(us-M.S.0/unit-N): <summary>` (never omit `/unit-N`).
   - **Patch Branch**: `patch/us-M.S.0-<scope>` or `patch/module-M-<scope>` | **Patch PR Title**: `fix(us-M.S.0): <summary>`.
   - **Story Branch**: `feat/us-M.S.0-<scope>` | **Story PR Title**: `feat(us-M.S.0): <story-title> (Units 1..K Promotion)`.
   - **Module Branch**: `feat/module-M-<scope>` | **Module PR Title**: `feat(module-M): <module-title>`.
2. **Bottom-Up PR Creation & Streaming Cascading Merge**:
   - Child unit PRs (`unit-1..K`) MUST be opened before the parent Story PR is opened.
   - As soon as each unit finishes implementation and passes its Unit Code Reviewer Council, `Git Workflow Master` immediately commits, pushes (`git push -u origin <branch>`), and opens its GitHub PR (`gh pr create`).
   - Merges into the story branch happen strictly via **`gh pr merge <PR> --merge`** in ordered cascading sequence ($1 \to 2 \to \dots \to K$): Unit 1 merges immediately upon approval; Unit 2 syncs the updated story branch, re-verifies tests/gates, and merges; continuing through Unit $K$. Local cross-tier `git merge` bypassing GitHub PRs is prohibited.

---

## Rule 6: In-PR Conversation Reporting & GitHub Projects Kanban (Zero Local Report/Kanban Clutter)

1. **All Reports Posted Directly to GitHub PR Conversations (`gh pr comment`)**:
   - **Do NOT generate local markdown report files** in `.agents/reports/`.
   - Every Implementation Report, Security Audit Report (`security-audit`), Cyclomatic Complexity Evaluation (`cyclomatic-complexity`), Patch Remediation Summary, and Gate G-Review Sign-Off MUST be posted directly as structured comments on the GitHub Pull Request conversation using `gh pr comment <PR> --body "..."` (or `./scripts/post-pr-report.sh`).
   - Merging any PR without a complete in-conversation audit trail (Implementation Report + Security/Complexity Audit + Independent Reviewer Sign-Off) is strictly blocked.
2. **GitHub Projects v2 Kanban Board + Local `checkpoint.json`**:
   - **Do NOT maintain local `KANBAN.md` files.**
   - All visual Kanban task tracking (`Todo`, `In Progress`, `In Review / PR Open`, `Merged`) MUST be managed through **GitHub Projects** (`gh project item-add` / `gh project item-edit` via `./scripts/gh-kanban-sync.sh`).
   - Simultaneously, maintain `.agents/checkpoints/<module-id>/checkpoint.json` on every worktree creation, PR creation, and PR merge for instant, idempotent state reconciliation and zero-duplication recovery.

---

## Rule 7: Pluggable Specialist Roster (`msitarzewski/agency-agents`) & Single-Profile Quota Sentinel

1. **Custom Project Agent Roster Selection**:
   - This plugin is 100% language-, framework-, and domain-agnostic. Users select the specialized domain and engineering agents their project requires from the bundled **[`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents)** catalog (all 18 divisions and 283 specialist agents included under `agents/agency-catalog/` and selectable via `./scripts/select-agents.sh`).
2. **Single-Profile Operation & Autonomous `quota-sentinel`**:
   - This plugin operates on **a single profile at a time**.
   - An autonomous **`quota-sentinel`** subagent monitors token velocity and API quota consumption. If remaining quota drops to **1%** or a rate-limit (`429` / `RESOURCE_EXHAUSTED`) is detected, `quota-sentinel` broadcasts an immediate pause alert, flushes state to `.agents/checkpoints/<module-id>/checkpoint.json`, and schedules a wakeup timer until quota resets—resuming without duplicating any worktree, branch, or PR.
