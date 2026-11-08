# some-divide-and-conquer

<div align="center">

<p align="center">
  <a href="https://github.com/some-of-cs">
    <img src="assets/some-of-cs-logo.png" alt="Some(CS) Organization Logo" width="120" height="120" style="vertical-align: middle; border-radius: 20px; margin-right: 16px;" />
  </a>
  <a href="https://github.com/some-of-cs/some-divide-and-conquer">
    <img src="assets/plugin-logo.svg" alt="some-divide-and-conquer Plugin Logo" width="120" height="120" style="vertical-align: middle;" />
  </a>
</p>

> **Autonomous Divide-and-Conquer Software Engineering Plugin for Google Antigravity, Claude Code & OpenAI Codex (`some-divide-and-conquer`).**  
> Transform monolithic specifications into parallel Modules, User Stories, and non-blocking Implementation Units inside isolated Git worktrees • Multi-Council Code Review • Mandatory `patch-implementer` Self-Correction • GitHub Projects Kanban • Full `cloudflare/security-audit-skill` • 283+ Pluggable Specialist Agents from `msitarzewski/agency-agents`

[![Some(CS) Org](https://img.shields.io/badge/Org-Some(CS)-0F2942.svg)](https://github.com/some-of-cs)
[![Antigravity Plugin](https://img.shields.io/badge/Antigravity-Marketplace%20Plugin-4285F4.svg)](plugin.json)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Marketplace%20Plugin-D97757.svg)](.claude-plugin/marketplace.json)
[![OpenAI Codex Plugin](https://img.shields.io/badge/OpenAI%20Codex-CLI%20%26%20Skills-10A37F.svg)](codex.json)
[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](plugin.json)
[![Model Family](https://img.shields.io/badge/Optimized%20For-Gemini%20Flash%20Family-8E75B2.svg)](#token-consumption--gemini-flash-family-optimization)
[![Agency Agents](https://img.shields.io/badge/Agency%20Agents-283%20Bundled%20(18%20Divisions)-22C55E.svg)](https://github.com/msitarzewski/agency-agents)
[![Security Audit Skill](https://img.shields.io/badge/Security%20Audit-cloudflare%2Fsecurity--audit--skill-F38020.svg)](https://github.com/cloudflare/security-audit-skill)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![Sponsor](https://img.shields.io/badge/Sponsor-%E2%99%A5-ff69b4.svg)](https://github.com/sponsors/some-of-cs)

[Overview](#why-some-divide-and-conquer) •
[Token & Model Guidance](#token-consumption--gemini-flash-family-optimization) •
[Prerequisites (`git` & `gh`)](#prerequisites-mandatory-git--gh-preflight-gate) •
[Monolith $\to$ Units Matrix](#from-monolithic-docs-to-non-blocking-implementation-units) •
[Parallel Architecture & `patch-implementer`](#parallel-execution-multi-council-review--patch-implementer-loop) •
[Agency Roster (283 Agents)](#choosing-your-project-agents-msitarzewskiagency-agents) •
[Quick Start](#installation--quick-start) •
[`some-stripe` Case Study](#real-world-case-study-some-stripe-v080) •
[Sponsors](#backers--corporate-sponsors)

</div>

---

## Why `some-divide-and-conquer`?

Single-agent coding workflows break down on large specifications: context windows fill up with compiler noise, sequential task execution takes hours, unreviewed commits introduce regressions, and local status files (`KANBAN.md`) create endless merge conflicts.

**`some-divide-and-conquer`** is a **language-, framework-, and product-agnostic** Google Antigravity, Claude Code, and OpenAI Codex plugin by **[Some(CS)](https://github.com/some-of-cs)** that turns any monolithic specification into a self-governing, parallel multi-agent software factory:

1. **Monolithic Docs $\to$ Modules $\to$ User Stories $\to$ Dynamic $K$ Implementation Units**:
   - Systematically decomposes huge PRDs, RFCs, or research documents into bounded **Modules**, cohesive **User Stories**, and a **dynamically calculated number ($K \in [1, N]$) of pure-implementation vertical slices** using a quantitative **Unit Sizing Decision Matrix**.
2. **100% Parallel, Non-Blocking Execution in Isolated `.worktrees/`**:
   - Every Implementation Unit is a **pure implementation slice** (never a validation-only unit waiting on siblings) with orthogonal file/module boundaries so **all $K$ units run simultaneously in parallel** inside `.worktrees/`.
3. **Concurrent Multi-Council Code Review & Mandatory `patch-implementer` Loop**:
   - Multiple independent **Code Reviewing Councils** run in parallel across Units, Stories, and Modules—auditing **Gate G0** (build/lint), **Gate G1** (test coverage), **Gate G2** (`security-audit`), **Gate G-Complexity** (`cyclomatic-complexity`), and **Gate G-Docs**.
   - Story and Module Leaders **never fix code directly in their own context**; any issue flagged by a Council automatically spawns an isolated **`patch-implementer`** subagent (`patch/*` branch & PR) in a continuous self-correction loop until 0 issues remain.
4. **GitHub Projects Visual Kanban & In-PR Conversation Audit Trail (Zero Local Report/Kanban Clutter)**:
   - Development status (`Todo`, `In Progress`, `In Review / PR Open`, `Merged`) is tracked visually in **GitHub Projects** (`gh project`) alongside a local `.agents/checkpoints/<module-id>/checkpoint.json`.
   - All Implementation Reports, Security Audits, Cyclomatic Complexity tables, and Council Sign-Offs are posted **directly as comments inside the GitHub Pull Request conversation (`gh pr comment`)** rather than cluttering the repository with local report files.
5. **Pluggable 283-Agent Specialist Roster ([`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents))**:
   - Choose the exact specialists your project needs from **all 18 divisions and 283 agents** of `msitarzewski/agency-agents`—whether you are building a Rust SDK, a TypeScript/React SaaS, a Python AI pipeline, a Go microservice, a mobile app, or a Unity/Unreal game.

---

## Token Consumption & Gemini Flash Family Optimization

> [!IMPORTANT]
> ### High Code Quality vs. High Token Consumption (Designed for the Gemini Flash Family)
> - **Extreme Output Quality**: By running $K$ parallel Unit Implementers, multiple concurrent Code Reviewing Councils (`security-audit` + `cyclomatic-complexity`), and automated `patch-implementer` remediation loops across every tier, this plugin produces **exceptionally high-quality, zero-warning, production-grade code and products**.
> - **High Token Consumption Trade-Off**: Because every unit, patch, story, and module undergoes full independent multi-agent implementation and multi-council verification, **this workflow consumes a large volume of tokens**.
> - **Primary Target — Gemini Flash Family**: This plugin is **mainly developed, tuned, and recommended for the Gemini Flash family** (such as `gemini-2.5-flash` and `gemini-3-flash`), which delivers the high speed, large context window, and token cost-efficiency required for parallel multi-agent swarms.
> - **Single-Profile Operation with `quota-sentinel`**: This plugin operates on **one profile at a time**. A dedicated autonomous **`quota-sentinel`** monitors token velocity and rate limits (`429` / `1%` remaining capacity), automatically flushing state to `.agents/checkpoints/<module-id>/checkpoint.json`, pausing active agents, and scheduling an automatic wakeup timer until your quota resets.

---

## Prerequisites: Mandatory `git` & `gh` Preflight Gate

Before the plugin starts any decomposition, worktree provisioning, or agent spawning, **Gate 0 (`scripts/preflight-check.sh`)** verifies that both **`git`** and **`gh` (GitHub CLI)** exist on `$PATH` and are authenticated:

| Prerequisite | Minimum Version | Why It Is Required Before Starting |
| :--- | :--- | :--- |
| **`git`** | `>= 2.30` | Provisions isolated `.worktrees/` for parallel Module, Story, Unit, and Patch agents. |
| **`gh` (GitHub CLI)** | `>= 2.30` | Creates PRs (`gh pr create`), posts in-conversation reports (`gh pr comment`), syncs GitHub Projects Kanban (`gh project`), and executes cascading merges (`gh pr merge`). |

Verify your environment at any time:

```bash
./scripts/preflight-check.sh
```

*(This check also runs automatically on `SessionStart` via [`hooks.json`](hooks.json). If either `git` or `gh` is missing, the plugin halts immediately before spawning any agents.)*

---

## From Monolithic Docs to Non-Blocking Implementation Units

The [`spec-decomposition`](skills/spec-decomposition/SKILL.md) skill provides a formal 4-level pipeline to turn any monolithic specification into parallel execution units:

```mermaid
flowchart TD
    Doc["Level 0: Monolithic Spec / PRD / RFC / Research Doc"] --> Mod1["Level 1: Module 1 (feat/module-1-...)"]
    Doc --> Mod2["Level 1: Module 2 (feat/module-2-...)"]
    Doc --> ModM["Level 1: Module M (feat/module-M-...)"]

    Mod1 --> Story1["Level 2: User Story 1.1 (feat/us-1.1.0-...)"]
    Mod1 --> Story2["Level 2: User Story 1.2 (feat/us-1.2.0-...)"]

    Story1 --> U1["Level 3: Unit 1 (feat/us-1.1.0/unit-1-...)"]
    Story1 --> U2["Level 3: Unit 2 (feat/us-1.1.0/unit-2-...)"]
    Story1 --> UK["Level 3: Unit K (feat/us-1.1.0/unit-K-...)"]
```

### Dynamic Implementation Unit Sizing Matrix ($K$ Is Not Fixed at 5)

Implementation units per User Story **do not have to be 5**—a story can require fewer (e.g., 2 or 3) or more (e.g., 6, 7, or 8+) depending on its complexity and surface area. Calculate the **Story Decomposition Score ($S_{\text{story}}$)**:

| Dimension | Weight | Score = `1` (Low) | Score = `2` (Medium) | Score = `3` (High) | Score = `4` (Very High) |
| :--- | :---: | :--- | :--- | :--- | :--- |
| **$D_1$: Entities / Endpoints / Components** | **35%** | 1–2 items | 3–4 items | 5–6 items | 7+ items |
| **$D_2$: Estimated Production LOC** | **25%** | $< 300$ LOC | $300 - 700$ LOC | $700 - 1,400$ LOC | $> 1,400$ LOC |
| **$D_3$: Algorithmic / Protocol Complexity** | **20%** | Simple CRUD / UI | Validation / state machine | Crypto / streaming / dual-protocol | Concurrency / distributed state |
| **$D_4$: Natural Orthogonal Boundaries** | **20%** | 1–2 files/modules | 3–4 independent files/modules | 5–6 independent files/modules | 7+ independent files/modules |

$$S_{\text{story}} = 0.35 D_1 + 0.25 D_2 + 0.20 D_3 + 0.20 D_4$$

| Story Score ($S_{\text{story}}$) | Recommended Units ($K$) | Typical Story Profile |
| :---: | :---: | :--- |
| **$1.00 - 1.25$** | **1–2 Units** | Compact config, utility, or 2-component slice ($150-250$ LOC/unit) |
| **$1.26 - 2.00$** | **3 Units** | Focused domain model + service + handler/controller slice |
| **$2.01 - 2.55$** | **4 Units** | Medium multi-endpoint or full-stack feature slice |
| **$2.56 - 3.10$** | **5 Units** | Rich domain story (models, CRUD, streaming/pagination, lifecycle actions) |
| **$3.11 - 3.55$** | **6–7 Units** | Large subsystem spanning 6–7 orthogonal submodules |
| **$3.56 - 4.00$** | **8+ Units (or Split Story)** | Mega-story: partition into 8 parallel units or split into two User Stories |

### Two Non-Negotiable Unit Design Invariants

1. **Pure Deliverable Production Only (Zero Validation-Only Units)**:
   - Every unit $1..K$ MUST produce real primary artifacts (source code + unit tests in software; drafted sections, models, or campaign assets + self-checks in non-software).
   - **Never** create a unit whose purpose is *"Unit $K$: Write integration tests or validate Units $1..(K-1)$"*. Story-level integration testing is performed by the Story Leader after all $K$ units merge.
2. **Zero Inter-Unit Blocking (100% Parallel Execution)**:
   - Units $1..K$ own disjoint files/submodules (with any shared interfaces seeded on the story branch first) so **all $K$ Unit Implementers run simultaneously in parallel** without waiting on one another.

---

## Parallel Execution, Multi-Council Review & `patch-implementer` Loop

```mermaid
flowchart TD
    SL["Story Leader (1m Watchdog)"] --> U1["Unit 1 Implementer (.worktrees/unit-1)"]
    SL --> U2["Unit 2 Implementer (.worktrees/unit-2)"]
    SL --> UK["Unit K Implementer (.worktrees/unit-K)"]

    U1 --> C1["Unit 1 Code Reviewing Council"]
    U2 --> C2["Unit 2 Code Reviewing Council"]
    UK --> CK["Unit K Code Reviewing Council"]

    C1 --> Q["Cascading gh pr merge (1 -> 2 -> ... -> K) into Story Branch"]
    C2 --> Q
    CK --> Q

    Q --> SC["Story-Level Code Reviewing Council"]
    SC -- "Issues Flagged" --> PI["Spawn Dedicated patch-implementer (patch/us-M.S.0-*)"]
    PI -- "PR Reviewed & Merged via gh pr merge" --> SC
    SC -- "100% Clean Sign-Off" --> MP["Merge Story PR into Module Branch via gh pr merge"]
```

### How the 3-Tier Review & `patch-implementer` Loop Works

1. **Parallel Unit Councils**:
   - Each Unit Implementer ($1..K$) invokes its own independent **Code Reviewing Council** in parallel as soon as its PR opens. If any issue or high complexity ($CC > 10$) is found, the Unit Implementer fixes it and re-invokes the Council until `GATE G-REVIEW APPROVED` is posted in the PR conversation.
2. **Story-Level Review & Mandatory `patch-implementer`**:
   - Once Units $1..K$ merge into `feat/us-M.S.0-<slug>`, the Story Leader opens the Story PR and invokes a fresh Story-level **Code Reviewing Council**.
   - **Strict Invariant**: If ANY issue is found at the story level, the **Story Leader NEVER fixes code directly in its own context**. It spawns a dedicated **`patch-implementer`** subagent in `.worktrees/patch-us-M.S.0-<scope>`, opens a Patch PR, merges it into the story branch via `gh pr merge`, and re-invokes the Story Council until 0 problems remain.
3. **Module-Level Review & Mandatory `patch-implementer`**:
   - Once all User Stories merge into `feat/module-M-<slug>`, the Module Leader invokes a Module-level **Code Reviewing Council**. Any findings trigger a dedicated **`patch-implementer`** on `patch/module-M-<scope>` until 100% clean sign-off is achieved.
4. **End-of-Module Whole-Codebase Validation**:
   - After the Module PR merges into `main`, the Main Supervisor runs the entire repository's test suite, linter, formatter, and doctests across Modules $1..M$ with a Whole-Codebase Gatekeeper Council.

---

## Bundled Reviewing Council & Orchestration Skills

All skills used by the Orchestrators and Code Reviewing Councils are included in [`skills/`](skills/):

| Skill | Purpose & Enforced Thresholds |
| :--- | :--- |
| **[`preflight-git-gh`](skills/preflight-git-gh/SKILL.md)** | **Gate 0**: Verifies `git` ($\ge 2.30$), `gh`, and `gh auth status` before starting the plugin. |
| **[`spec-decomposition`](skills/spec-decomposition/SKILL.md)** | Decomposes monolithic docs into Modules, User Stories, and Dynamic $K$ non-blocking Units. |
| **[`divide-and-conquer-orchestrator`](skills/divide-and-conquer-orchestrator/SKILL.md)** | Manages parallel `.worktrees/`, 3m/1m watchdogs, streaming PRs, and cascading `gh pr merge`. |
| **[`code-review-council`](skills/code-review-council/SKILL.md)** | Runs parallel Multi-Council reviews (Gates G0, G1, G2, G-Complexity, G-Docs, G-Review) & `patch-implementer` loops. |
| **[`cyclomatic-complexity`](skills/cyclomatic-complexity/SKILL.md)** | **Gate G-Complexity**: Language-agnostic $CC = 1 + \sum \text{decision points}$ ($CC \le 6$ target, $\le 10$ ceiling, $>15$ hard merge blocker, nesting $\le 2$). |
| **[`security-audit`](skills/security-audit/SKILL.md)** | **Gate G2**: Full **[`cloudflare/security-audit-skill`](https://github.com/cloudflare/security-audit-skill)** suite (`RECONNAISSANCE.md`, `HUNTING.md`, `ATTACK-CLASSES.md`, 11 domain playbooks, `report-schema.json`, `validate-findings.cjs`, `validate-coverage-ledger.cjs`). |
| **[`github-projects-kanban`](skills/github-projects-kanban/SKILL.md)** | Syncs visual Kanban status with **GitHub Projects** (`gh project`) + `.agents/checkpoints/` and posts all reports to **PR conversations**. |
| **[`agency-roster-selector`](skills/agency-roster-selector/SKILL.md)** | Interactive/CLI selector for all 283 agents across 18 divisions from `msitarzewski/agency-agents`. |

---

## Choosing Your Project Agents (`msitarzewski/agency-agents`)

Because `some-divide-and-conquer` is completely generic across all languages and domains, it bundles **all 18 divisions and 283 specialist agents** from [`https://github.com/msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) under [`agents/agency-catalog/`](agents/agency-catalog/):

- **Engineering (66 agents)**: `backend-architect`, `frontend-developer`, `ai-engineer`, `devops-automator`, `database-optimizer`, `mobile-app-builder`, `api-platform-engineer`, `code-reviewer`, `git-workflow-master`, and more.
- **Security (12 agents)**: `application-security-engineer`, `ai-generated-code-security-auditor`, `penetration-tester`, `cloud-security-architect`, `compliance-auditor`, `security-architect`.
- **Testing (9 agents)**: `api-tester`, `performance-benchmarker`, `test-automation-engineer`, `accessibility-auditor`, `test-results-analyzer`.
- **Design, Product, Project Management, Game Dev, Spatial Computing, Finance, Healthcare, GIS, Specialized, Research, Academic, Marketing, Paid Media, Sales, Support** (all 18 divisions included).

### Universal `--field` Industry Targeting Presets (`profiles/fields.json`)

Pass `--field <FIELD_PROFILE>` to `install-plugin.sh`, `select-agents.sh`, or `post-pr-report.sh` to dynamically configure the default `agency-agents` divisions, $D_1..D_4$ sizing metrics, and 6-Gate Reviewing Council rubric (stored in `.agents/field-profile.json`):

| `--field` Flag | Auto-Enabled Divisions | $D_1$ (35% Surface) & $D_2$ (25% Volume) | Gate G0 (Format/Build) & Gate G1 (Verification) | Gate G2 (Risk/Safety) & Gate G-Complexity (Clarity) |
| :--- | :--- | :--- | :--- | :--- |
| **`software`** *(default)* | `engineering,security,testing` | **$D_1$**: Entities/endpoints; **$D_2$**: Production LOC ($<300$ to $>1,400$) | **G0**: Compiler, linter, formatter (0 warnings). **G1**: Unit/integration tests ($\ge 90\%$ coverage). | **G2**: `security-audit` (OWASP, secrets, crypto). **G-Complexity**: Cyclomatic $CC \le 6$ (cap 10). |
| **`product`** | `product,design,project-management,research` | **$D_1$**: User flows/personas/screens; **$D_2$**: Spec depth ($<800$ to $>4,000$ words) | **G0**: Schema, template & link validation. **G1**: 100% acceptance-criteria & edge-case traceability. | **G2**: Privacy, accessibility (WCAG/Section 508) & UX dark-pattern audit. **G-Complexity**: Flow branching depth $\le 2$, unambiguous scope. |
| **`marketing`** | `marketing,paid-media,sales,design` | **$D_1$**: Channels/funnels/creatives; **$D_2$**: Asset count & copy volume | **G0**: Brand voice, style guide & SEO/UTM lint. **G1**: Conversion tracking, A/B hypothesis & KPI completeness. | **G2**: FTC/ad-policy compliance, claim substantiation & brand safety. **G-Complexity**: Readability grade & single-CTA clarity. |
| **`finance`** | `finance,specialized,support` | **$D_1$**: Models/statements/scenarios; **$D_2$**: Schedules, formulas & sensitivity tables | **G0**: Formula integrity, balance reconciliation (0 rounding drift). **G1**: Stress-test & sensitivity scenario verification. | **G2**: Tax/regulatory/audit compliance (SOX/IFRS/GAAP) & PII redaction. **G-Complexity**: Model modularity & transparent assumptions. |
| **`research`** | `academic,research,specialized` | **$D_1$**: Hypotheses/sections/datasets; **$D_2$**: Word count & citation density | **G0**: Citation format, bibliography & figure/table numbering check. **G1**: Statistical validity, methodology & source verification. | **G2**: Plagiarism/hallucination check, ethics & bias audit. **G-Complexity**: Argument cohesion & readability. |
| **`healthcare`** | `healthcare,security,academic,support` | **$D_1$**: Clinical pathways/protocols; **$D_2$**: Evidence tables & regulatory modules | **G0**: Terminology standards (ICD/SNOMED/FHIR) & template check. **G1**: Clinical evidence grading & protocol verification. | **G2**: HIPAA/PHI privacy, patient-safety & regulatory compliance. **G-Complexity**: Decision-tree clarity ($\le 2$ nested conditions). |
| **`game-dev`** | `game-development,spatial-computing,design,testing` | **$D_1$**: Mechanics/systems/shaders/levels; **$D_2$**: Script LOC or scene asset count | **G0**: Engine build, shader compile & asset budget check. **G1**: Frame-time budget, multiplayer sync & playtest assertions. | **G2**: Anti-cheat, economy exploit & state-desync audit. **G-Complexity**: Script $CC \le 6$ & state-machine simplicity. |
| **`gis`** | `gis,engineering,testing` | **$D_1$**: Layers/pipelines/projections; **$D_2$**: Spatial scripts & dataset schemas | **G0**: CRS/projection validation, GeoJSON/WKT schema lint. **G1**: Spatial topology, bounds & accuracy verification. | **G2**: Geoprivacy & data-licensing compliance. **G-Complexity**: Geoprocessing pipeline modularity. |

Browse and enable the exact agents or field preset your project needs:

```bash
# List all --field presets and their auto-enabled divisions
./scripts/select-agents.sh --list-fields

# Enable an entire industry field preset with one flag (writes .agents/field-profile.json)
./scripts/select-agents.sh --field research --target /path/to/your/project

# List all 18 divisions and agent counts
./scripts/select-agents.sh --list-divisions

# Search for specialists by technology or domain
./scripts/select-agents.sh --search "security"
./scripts/select-agents.sh --search "frontend"

# Enable specific divisions into your target project
./scripts/select-agents.sh --divisions engineering,security,testing --target /path/to/your/project

# Or enable specific individual agents by slug
./scripts/select-agents.sh --agents backend-architect,frontend-developer,application-security-engineer,api-tester --target /path/to/your/project

# Or enable ALL 283 agents across all 18 divisions
./scripts/select-agents.sh --all --target /path/to/your/project
```

---

## Installation & Quick Start (Antigravity, Claude Code & OpenAI Codex)

This repository is structured as a **Universal Tri-Platform Plugin (`some-divide-and-conquer`)** ready for direct publishing and installation across **Google Antigravity**, **Claude Code**, and **OpenAI Codex CLI**.

### Option A: Google Antigravity Marketplace / CLI (`agy`)

1. **Native Antigravity Plugin Manifest**: [`plugin.json`](plugin.json) (with [`hooks.json`](hooks.json) and [`rules/AGENTS.md`](rules/AGENTS.md)).
2. **Install into any workspace**:
   ```bash
   git clone https://github.com/some-of-cs/some-divide-and-conquer.git some-divide-and-conquer
   ./some-divide-and-conquer/scripts/install-plugin.sh \
     --tool antigravity \
     --target /path/to/your/project \
     --divisions engineering,security,testing
   ```

### Option B: Claude Code Plugin Marketplace (`/plugin`)

1. **Native Claude Code Manifests**: [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) and [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json).
2. **Install directly from the Claude Code Marketplace**:
   ```text
   /plugin marketplace add some-of-cs/some-divide-and-conquer
   /plugin install some-divide-and-conquer@some-divide-and-conquer-marketplace
   ```
3. **Included Claude Code Slash Commands ([`.claude-plugin/commands/`](.claude-plugin/commands/))**:
   - `/divide-and-conquer <spec-or-module>` — Execute the full Divide-and-Conquer workflow
   - `/decompose-spec <spec-path>` — Decompose a monolithic doc into Modules, Stories, and Dynamic $K$ Units
   - `/council-review <pr-number>` — Run an independent Code Reviewing Council audit on a PR
   - `/select-agents <options>` — Enable specialist agents from `msitarzewski/agency-agents`
   - `/kanban-sync <init|status>` — Sync GitHub Projects Kanban & `checkpoint.json`

### Option C: OpenAI Codex CLI (`codex`)

1. **Native Codex Manifests**: [`codex.json`](codex.json), [`.codex-plugin/plugin.json`](.codex-plugin/plugin.json), and [`rules/AGENTS.md`](rules/AGENTS.md).
2. **Install into any Codex workspace**:
   ```bash
   ./some-divide-and-conquer/scripts/install-plugin.sh \
     --tool codex \
     --target /path/to/your/project \
     --divisions engineering,security,testing
   ```

### Option D: Install for All Platforms Simultaneously (`--tool all`)

```bash
# Default software engineering preset (--field software)
./some-divide-and-conquer/scripts/install-plugin.sh \
  --tool all \
  --field software \
  --target /path/to/your/project

# Or target any industry domain (product, marketing, finance, research, healthcare, game-dev, gis)
./some-divide-and-conquer/scripts/install-plugin.sh \
  --tool all \
  --field research \
  --target /path/to/your/project
```

### Initialize GitHub Projects Kanban & Start Orchestration

```bash
cd /path/to/your/project
./scripts/gh-kanban-sync.sh init \
  --module module-1 \
  --title "Module 1: Core Platform" \
  --project-number 1
```

Then prompt your agent (or run `/divide-and-conquer docs/SPECIFICATION.md`):

```text
Using the some-divide-and-conquer plugin rules and the spec-decomposition skill:
1. Run ./scripts/preflight-check.sh to verify git and gh are ready.
2. Decompose docs/SPECIFICATION.md into bounded Modules, User Stories, and dynamically sized, non-blocking Implementation Units (using the Unit Sizing Decision Matrix).
3. Sync the roadmap with our GitHub Project Kanban board and .agents/checkpoints/checkpoint.json.
4. Execute Module 1 by spawning parallel Story Leaders and Unit Implementers in .worktrees/, running parallel Code Reviewing Councils, using patch-implementer for any review findings, and posting all execution and review reports directly to the GitHub PR conversations.
```

---

## Real-World Case Study: `some-stripe` (`v0.8.0`)

See [`examples/some-stripe/`](examples/some-stripe/README.md) for the complete case study of how **[`some-stripe`](https://github.com/some-of-cs/some-stripe)**—an idiomatic Rust 2024 SDK and constant-time webhook engine for Stripe API v1 & v2—was built from a single monolithic research document using this exact workflow:

- **Input**: 1 monolithic specification (`Stripe Services and API Research.md`)
- **Output**: **8 Modules**, **16 User Stories**, **80 Parallel Implementation Units**, and **137 merged GitHub PRs**
- **Quality**: **705+ unit/wire tests**, **220+ runnable doctests**, **0 compiler/Clippy warnings**, **Max Cyclomatic Complexity $CC \le 6$** on primary paths, and **100% Gate G2 / Gate G-Law compliance**.

Explore the example artifacts:
- [Case Study Overview (`examples/some-stripe/README.md`)](examples/some-stripe/README.md)
- [Dynamic Unit Sizing Walkthrough (`examples/some-stripe/decomposition-walkthrough.md`)](examples/some-stripe/decomposition-walkthrough.md)
- [Sample In-PR Conversation Audit Reports (`examples/some-stripe/sample-pr-conversation-reports.md`)](examples/some-stripe/sample-pr-conversation-reports.md)
- [Sample Checkpoint Store (`examples/some-stripe/sample-checkpoint.json`)](examples/some-stripe/sample-checkpoint.json)

---

## Repository Structure

```text
some-divide-and-conquer/
├── plugin.json                                     # Google Antigravity Marketplace Manifest
├── .claude-plugin/
│   ├── plugin.json                                 # Claude Code Plugin Manifest
│   ├── marketplace.json                            # Claude Code Marketplace Catalog Manifest
│   ├── hooks.json                                  # Claude Code SessionStart hook (git & gh check)
│   └── commands/                                   # Slash commands (/divide-and-conquer, /decompose-spec, etc.)
├── .codex-plugin/plugin.json                       # OpenAI Codex Plugin Manifest
├── codex.json                                      # OpenAI Codex CLI root configuration
├── hooks.json                                      # Antigravity SessionStart hook (git & gh check)
├── assets/
│   ├── logo.svg                                    # Primary plugin logo SVG
│   ├── plugin-logo.svg                             # some-divide-and-conquer plugin emblem SVG
│   ├── some-of-cs-logo.png                         # Official Some(CS) organization logo PNG
│   └── some-of-cs-logo.svg                         # Official Some(CS) organization logo SVG
├── profiles/
│   └── fields.json                                 # Field-targeting registry (--field software|product|marketing|finance|research|healthcare|game-dev|gis)
├── rules/
│   ├── AGENTS.md                                   # Consolidated workspace governance rules (<24 KB)
│   └── references/                                 # Deep-dive reference guides (Rules 01..06)
├── skills/
│   ├── preflight-git-gh/SKILL.md                   # Gate 0: git & gh CLI verification
│   ├── spec-decomposition/SKILL.md                 # Monolith -> Modules -> Stories -> Dynamic K-Unit Matrix
│   ├── divide-and-conquer-orchestrator/SKILL.md    # Parallel .worktrees/ & cascading gh pr merge
│   ├── code-review-council/SKILL.md                # Multi-Council review & patch-implementer loop
│   ├── cyclomatic-complexity/SKILL.md              # Language-agnostic CC <= 6 target, <= 10 cap, >15 blocker
│   ├── security-audit/                             # Complete cloudflare/security-audit-skill suite (23 files)
│   ├── github-projects-kanban/SKILL.md             # GitHub Projects v2 Kanban + checkpoint.json + PR reports
│   └── agency-roster-selector/SKILL.md             # Selector for all 283 msitarzewski/agency-agents
├── agents/
│   ├── *.md                                        # 7 core orchestration & council agent definitions
│   └── agency-catalog/                             # All 18 divisions & 283 agents from msitarzewski/agency-agents
├── scripts/
│   ├── preflight-check.sh                          # Verifies git and gh exist before starting
│   ├── install-plugin.sh                           # Tri-platform installer (--tool antigravity|claude|codex|all)
│   ├── select-agents.sh                            # Interactive/CLI selector for the 283 agency-agents
│   ├── gh-kanban-sync.sh                           # Syncs GitHub Projects Kanban & checkpoint.json
│   └── post-pr-report.sh                           # Posts Implementation & Council Reports to PR conversations
└── examples/
    └── some-stripe/                                # Real-world flagship case study (some-stripe v0.8.0)
```

---

## Backers & Corporate Sponsors

`some-divide-and-conquer` is an independent, community-driven open-source project by **[Some(CS)](https://github.com/some-of-cs)** built for the Google Antigravity, Claude Code, and OpenAI Codex ecosystems. If your engineering team or company relies on this plugin to orchestrate autonomous multi-agent software delivery and automated code review councils, corporate sponsorship directly funds continuous maintenance, new orchestration skills, and expanded agent integrations.

<div align="center">

[![Become a Sponsor](https://img.shields.io/badge/Become%20a%20Sponsor-%E2%99%A5-ea4aaa?style=for-the-badge)](https://github.com/sponsors/some-of-cs)

</div>

### Corporate Sponsorship Tiers & Benefits

| Tier | Monthly | Placement & Benefits |
| :--- | :--- | :--- |
| **🏆 Visionary** | $1,000 / mo | Large logo on `README.md`, website, and Marketplace header • Prioritized GitHub issues • Dedicated quarterly workflow & agent architecture review |
| **🥇 Gold Partner** | $500 / mo | Prominent logo on `README.md` • Prioritized PR reviews • Direct issue escalation |
| **🥈 Silver Backer** | $150 / mo | Company logo, link, and mention in `README.md` and release changelogs |
| **☕ Individual** | $10 – $50 / mo | Listed as a contributor and backer on GitHub |

> [!TIP]
> **Need an Invoice or Procurement Documentation?**  
> We can issue formal VAT/sales-tax compliant invoices via Stripe Invoicing for corporate sponsors. Please contact [sponsors@someofcs.tech](mailto:sponsors@someofcs.tech).

---

## Acknowledgments & Special Thanks

<div align="center">

### 🙏 Huge Thanks to [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) & [`cloudflare/security-audit-skill`](https://github.com/cloudflare/security-audit-skill)

[![Agency Agents Repo](https://img.shields.io/badge/GitHub-msitarzewski%2Fagency--agents-181717?style=for-the-badge&logo=github)](https://github.com/msitarzewski/agency-agents)
[![Cloudflare Security Audit Skill](https://img.shields.io/badge/GitHub-cloudflare%2Fsecurity--audit--skill-F38020?style=for-the-badge&logo=cloudflare)](https://github.com/cloudflare/security-audit-skill)

</div>

### 1. Special Thanks to [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents)

A **massive thank you** to **[`@msitarzewski`](https://github.com/msitarzewski)** and all contributors to **[`https://github.com/msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents)**!

`some-divide-and-conquer` directly depends on **The Agency** (`msitarzewski/agency-agents`) for its pluggable roster of **283 specialist AI agents across 18 divisions** (`engineering`, `security`, `testing`, `design`, `product`, `project-management`, `game-development`, `spatial-computing`, `finance`, `healthcare`, `gis`, `specialized`, `research`, `academic`, `marketing`, `paid-media`, `sales`, and `support`). Without their comprehensive, battle-tested collection of specialist agent personas and Antigravity skill integrations, making this Divide-and-Conquer orchestration engine truly universal across every programming language, framework, and industry would not have been possible.

👉 **Please visit and star [`https://github.com/msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) to support their work!**

### 2. Special Thanks to [`cloudflare/security-audit-skill`](https://github.com/cloudflare/security-audit-skill)

A **massive thank you** to **[Cloudflare](https://github.com/cloudflare)** and the authors of **[`https://github.com/cloudflare/security-audit-skill`](https://github.com/cloudflare/security-audit-skill)**!

Our Code Reviewing Councils depend directly on the complete **`cloudflare/security-audit-skill`** (bundled in [`skills/security-audit/`](skills/security-audit/SKILL.md)) for **Gate G2** security reviews, vulnerability reconnaissance (`RECONNAISSANCE.md`), variant hunting (`HUNTING.md`), attack-class modeling (`ATTACK-CLASSES.md`), domain-specific security playbooks (`WEB-PROTOCOL-AND-AUTH.md`, `MEMORY-SAFETY-AND-BINARY.md`, `AI-AND-LLM.md`, `CLOUD-AND-DEPLOYMENT.md`, `SUPPLY-CHAIN-AND-RELEASE.md`, and more), and automated coverage/finding validation (`validate-coverage-ledger.cjs`, `validate-findings.cjs`). Their rigorous methodology ensures every Unit, Patch, Story, and Module PR undergoes production-grade security verification before merge.

👉 **Please visit and star [`https://github.com/cloudflare/security-audit-skill`](https://github.com/cloudflare/security-audit-skill) to support their work!**

---

- Flagship real-world architectural validation powered by **[`some-stripe`](https://github.com/some-of-cs/some-stripe)** (`v0.8.0`).

---

## License

Licensed under the Apache License, Version 2.0 ([LICENSE](LICENSE)).
