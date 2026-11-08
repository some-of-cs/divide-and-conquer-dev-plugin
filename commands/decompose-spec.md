---
description: Decompose a monolithic specification, PRD, RFC, or research document into bounded Modules, User Stories, and dynamically sized non-blocking Implementation Units (1..K) using the Unit Sizing Decision Matrix.
argument-hint: <path-to-spec-doc>
---

# `/decompose-spec` — Monolithic Spec $\to$ Modules $\to$ Stories $\to$ Dynamic $K$ Units

Specification document to decompose: `$ARGUMENTS`

1. Load and follow the `spec-decomposition` skill (`skills/spec-decomposition/SKILL.md`).
2. Verify `git` and `gh` exist via `./scripts/preflight-check.sh`.
3. Read `$ARGUMENTS` and partition it into:
   - **Level 1: Modules (`module-1..M`)** — Bounded architectural contexts.
   - **Level 2: User Stories (`us-M.1.0..us-M.S.0`)** — Cohesive feature deliverables.
   - **Level 3: Implementation Units (`unit-1..K`)** — Calculate the weighted **Story Decomposition Score ($S_{\text{story}} = 0.35 D_1 + 0.25 D_2 + 0.20 D_3 + 0.20 D_4$)** for each story to determine the exact unit count $K \in [1, N]$.
4. Verify that every unit $1..K$ is a **pure implementation slice** (never a validation-only unit) and has disjoint file/module ownership so all $K$ units execute 100% in parallel without blocking one another.
5. Sync the resulting roadmap to **GitHub Projects Kanban** and `.agents/checkpoints/` using `./scripts/gh-kanban-sync.sh`.
