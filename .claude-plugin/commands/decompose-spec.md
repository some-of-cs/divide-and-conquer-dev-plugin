---
description: Decompose a monolithic specification, PRD, RFC, financial model, campaign brief, or research document into bounded Modules, User Stories, dynamically sized Implementation Units (1..K), an Architecture Roadmap, and per-module User Story Spec Kit documents (docs/user-stories/module-M/us-M.S.0.md).
argument-hint: <path-to-spec-doc> [--field <software|product|marketing|finance|research|healthcare|game-dev|gis>]
---

# `/decompose-spec` — Monolithic Spec $\to$ Modules $\to$ Stories $\to$ Dynamic $K$ Units & Spec Kit Docs

Specification document to decompose (and optional `--field` preset): `$ARGUMENTS`

1. Load and follow the `spec-decomposition` skill (`skills/spec-decomposition/SKILL.md`), `security-audit` skill (`skills/security-audit/SKILL.md`), and `profiles/fields.json` (or `.agents/field-profile.json`).
2. Verify `git` and `gh` exist via `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/preflight-check.sh`. If `--field <FIELD>` is provided, configure the field profile via `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh --field <FIELD> --target .`.
3. Read `$ARGUMENTS` and partition it into:
   - **Level 1: Modules (`module-1..M`)** — Bounded architectural contexts or workstreams.
   - **Level 2: User Stories (`us-M.1.0..us-M.S.0`)** — Cohesive feature or domain deliverables.
   - **Level 3: Implementation Units (`unit-1..K`)** — Calculate the weighted **Story Decomposition Score ($S_{\text{story}} = 0.35 D_1 + 0.25 D_2 + 0.20 D_3 + 0.20 D_4$)** using the active field's $D_1..D_4$ metrics to determine the exact unit count $K \in [1, N]$.
4. Generate the two required documentation deliverables:
   - **Architecture Roadmap**: `docs/architecture/DECOMPOSITION_ROADMAP.md`
   - **Per-Module User Story Spec Kit Suite**: `docs/user-stories/module-M-<slug>/us-M.S.0-<story-slug>.md` for every user story under its module folder, containing all 6 mandatory sections:
     1. **Spec Kit Specifications** (`1.1 User Story Narrative` with `1.1.1 Preconditions` & `1.1.2 Postconditions`, `1.2 Acceptance Criteria (Gherkin Scenarios)`, `1.3 Test Cases & Traceability Matrix`)
     2. **Technical Implementation Plan** (`2.1 Domain Invariants & Storage Schema`, and either `2.2 Activity Diagram` or `2.2 Sequence Diagram`)
     3. **Expected Folder Architecture at the Project**
     4. **Implementation Units in Detail & Specialist Agent Assignment** (`4.1` $S_{\text{story}}$ score, `4.2` unit specs, `4.3` best-fit agents per unit from `msitarzewski/agency-agents`, `4.4` parallel execution & contract seeding plan)
     5. **Security Gateway (Powered by `security-audit` Skill)** (`5.1 Trust Boundaries & Security Actors`, `5.2 Threat Modeling & Abuse Matrix (STRIDE / ASVS)`, `5.3 Cryptography & Global Data Protection Controls` for worldwide legal compliance, `5.4 Automated Security Verification Checklist`, `5.5 Security Gateway (G2) Sign-Off Checklist`)
     6. **Validation Gates & Acceptance Sign-Off**
5. Verify that every unit $1..K$ obeys **Pure Deliverable Production Only** (never a validation-only or review-only unit) and has disjoint file/module/section ownership so all $K$ units execute 100% in parallel without blocking one another.
6. Sync the resulting roadmap to **GitHub Projects Kanban** and `.agents/checkpoints/` using `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/gh-kanban-sync.sh`.
