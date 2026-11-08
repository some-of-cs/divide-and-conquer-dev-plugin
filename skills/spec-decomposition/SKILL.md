---
name: spec-decomposition
description: Transform monolithic specifications, PRDs, RFCs, or research documents into bounded Modules, User Stories, and a dynamically sized number of non-blocking, parallel Implementation Units (1..K) using a quantitative decision matrix.
---

# Monolithic Specification Decomposition Skill

Use this skill whenever the user provides a monolithic specification, architecture RFC, product requirements document (PRD), or research document and wants to build it using the **Divide-and-Conquer** workflow.

---

## 1. Four-Level Decomposition Hierarchy

```mermaid
flowchart TD
    M0["Level 0: Monolithic Specification / Research Doc / PRD"] --> M1["Level 1: Module 1 (feat/module-1-...)"]
    M0 --> M2["Level 1: Module 2 (feat/module-2-...)"]
    M0 --> MN["Level 1: Module M (feat/module-M-...)"]

    M1 --> S1["Level 2: User Story 1.1 (feat/us-1.1.0-...)"]
    M1 --> S2["Level 2: User Story 1.2 (feat/us-1.2.0-...)"]

    S1 --> U1["Level 3: Unit 1 (feat/us-1.1.0/unit-1-...)"]
    S1 --> U2["Level 3: Unit 2 (feat/us-1.1.0/unit-2-...)"]
    S1 --> UK["Level 3: Unit K (feat/us-1.1.0/unit-K-...)"]
```

### Level Definitions
1. **Level 1 — Modules (`module-1..M`)**:
   - **Scope**: Major architectural subsystems, domain bounded contexts, or service layers (e.g., Core Runtime, Authentication, Billing Engine, Frontend Dashboard).
   - **Rule**: Modules may have sequential phase dependencies (e.g., Module 1 Core Foundation before Module 2 Domain Services) or run in parallel if decoupled.
2. **Level 2 — User Stories (`us-M.1.0..us-M.S.0`)**:
   - **Scope**: Cohesive end-to-end feature deliverables within a Module (typically 2 to 4 User Stories per Module).
   - **Rule**: User Stories within a Module execute in parallel inside isolated `.worktrees/`.
3. **Level 3 — Implementation Units (`unit-1..K`)**:
   - **Scope**: Self-contained vertical implementation slices within a User Story.
   - **Rule**: Every unit is a **pure implementation slice** with its own unit tests, and **all $K$ units run 100% in parallel without blocking one another**.

---

## 2. Dynamic Implementation Unit Sizing Matrix ($K \in [1, N]$)

> [!IMPORTANT]
> **Units Do NOT Have to Be 5**: Never force a User Story into an arbitrary 5-unit template if the story naturally decomposes into 2, 3, 4, 6, or 8 units. Always calculate the **Story Decomposition Score ($S_{\text{story}}$)** using the matrix below to choose the exact number of implementation units $K$.

### Step 2.1: Score the User Story Across 4 Dimensions

| Dimension | Weight | Score = `1` | Score = `2` | Score = `3` | Score = `4` |
| :--- | :---: | :--- | :--- | :--- | :--- |
| **$D_1$: Entities / Endpoints / Components** | **35%** | 1–2 distinct items | 3–4 distinct items | 5–6 distinct items | 7+ distinct items |
| **$D_2$: Estimated Production LOC** | **25%** | $< 300$ LOC | $300 - 700$ LOC | $700 - 1,400$ LOC | $> 1,400$ LOC |
| **$D_3$: Algorithmic / Protocol Complexity** | **20%** | Simple CRUD / static UI | Validation / state machine | Crypto / streaming / dual-protocol | Concurrency / distributed consensus |
| **$D_4$: Natural Orthogonal Boundaries** | **20%** | 1–2 files/modules | 3–4 independent files/modules | 5–6 independent files/modules | 7+ independent files/modules |

Compute the weighted score:
$$S_{\text{story}} = (0.35 \times D_1) + (0.25 \times D_2) + (0.20 \times D_3) + (0.20 \times D_4)$$

### Step 2.2: Map $S_{\text{story}}$ to Implementation Unit Count ($K$)

| Weighted Score ($S_{\text{story}}$) | Unit Count ($K$) | Sizing Rationale & Target Slice Size |
| :---: | :---: | :--- |
| **$1.00 - 1.25$** | **1–2 Units** | Micro-story: 1–2 small components ($150-250$ LOC per unit). Over-splitting would create trivial files. |
| **$1.26 - 2.00$** | **3 Units** | Compact story: 3 orthogonal slices (e.g., Entity Models, Service Operations, Event/Webhook Handler). |
| **$2.01 - 2.55$** | **4 Units** | Medium story: 4 independent domain/feature slices ($200-350$ LOC per unit). |
| **$2.56 - 3.10$** | **5 Units** | Standard rich story: 5 vertical slices covering full domain, operations, streaming/pagination, and edge cases. |
| **$3.11 - 3.55$** | **6–7 Units** | Large story: 6–7 parallel slices across a wide API or UI surface. |
| **$3.56 - 4.00$** | **8+ Units (or Split Story)** | Mega-story: Either partition into 8 orthogonal units or split into two separate User Stories (`us-M.S.0` and `us-M.(S+1).0`). |

---

## 3. Hard Invariants for Implementation Units

### Invariant A: Pure Implementation Only (Zero Validation-Only Units)
- **Every unit $1..K$ MUST write production implementation code** plus its own unit tests.
- **STRICTLY PROHIBITED**: Creating a unit whose job is *"Unit $K$: Write integration tests / contract tests / benchmarks for Units $1..(K-1)$"*.
- **Why**: A validation-only unit cannot run until Units $1..(K-1)$ finish, turning a parallel pipeline into a sequential bottleneck. Story-wide integration verification belongs to the **Story Leader** after all $K$ units merge into the story branch.

### Invariant B: Zero Inter-Unit Blocking (100% Parallel Execution)
- Units $1..K$ MUST NOT depend on unmerged code from sibling units.
- **How to Achieve Zero Blocking**:
  1. **Disjoint File/Module Ownership**: Assign each unit its own dedicated files or submodules (e.g., `unit-1` owns `customer.rs`, `unit-2` owns `subscription.rs`, `unit-3` owns `invoice.rs`).
  2. **Story Base Contract Seeding**: If units share a common trait, interface, or base DTO, define that minimal stub/interface on the story branch (`feat/us-M.S.0-<slug>`) *before* branching `unit-1..K`.
  3. **Independent Compilation & Testing**: Each unit's worktree MUST compile and pass its unit tests independently without waiting for any sibling unit.

---

## 4. Decomposition Output Artifact & GitHub Projects Sync

After decomposing the monolithic spec:
1. Create the decomposition roadmap document (e.g., `docs/architecture/DECOMPOSITION_ROADMAP.md`) listing every Module, User Story, its calculated $S_{\text{story}}$ score, chosen unit count $K$, and the exact file ownership boundary of each Unit $1..K$.
2. Run `./scripts/gh-kanban-sync.sh init` to populate all Modules, User Stories, and Implementation Units on the **GitHub Projects Kanban board** and initialize `.agents/checkpoints/<module-id>/checkpoint.json`.
