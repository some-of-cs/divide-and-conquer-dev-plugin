# Reference 02: Turning Monolithic Docs into Modules, User Stories & Dynamic Implementation Units

## 1. The 4-Tier Decomposition Pipeline

```text
Monolithic Specification / Research Doc / PRD
  └── Module 1..M (Bounded Contexts / Subsystems)
        └── User Story M.1..M.S (Cohesive Feature Deliverables)
              └── Implementation Units 1..K (Parallel, Non-Blocking Vertical Slices)
```

## 2. Dynamic Implementation Unit Sizing Matrix ($K$ Is Not Fixed at 5)

Implementation units per User Story **do not have to be 5**—a story can have fewer (e.g., 2–3) or more (e.g., 6–8+) depending on its actual architectural footprint.

Compute the **Story Decomposition Score ($S_{\text{story}}$)** across 4 dimensions:

| Dimension | Weight | Score `1` (Low) | Score `2` (Medium) | Score `3` (High) | Score `4` (Very High) |
| :--- | :---: | :--- | :--- | :--- | :--- |
| **1. Functional Surface ($D_1$)** | $35\%$ | 1–2 models/endpoints/components | 3–4 models/endpoints/components | 5–6 models/endpoints/components | 7+ models/endpoints/components |
| **2. Estimated Code Volume ($D_2$)** | $25\%$ | $< 300$ LOC | $300 - 700$ LOC | $700 - 1,400$ LOC | $> 1,400$ LOC |
| **3. Logic & Algorithmic Complexity ($D_3$)** | $20\%$ | Simple CRUD / UI layout | State transitions / validation | Crypto / protocol / concurrency | Distributed / multi-protocol state machine |
| **4. Orthogonal Sub-Boundaries ($D_4$)** | $20\%$ | 1–2 files/modules | 3–4 decoupled files/modules | 5–6 decoupled files/modules | 7+ decoupled files/modules |

$$S_{\text{story}} = 0.35 D_1 + 0.25 D_2 + 0.20 D_3 + 0.20 D_4$$

### Recommended Implementation Unit Count ($K$)

| Story Score ($S_{\text{story}}$) | Recommended Units ($K$) | Typical Profile |
| :---: | :---: | :--- |
| **$1.00 - 1.50$** | **2 Units** | Small feature, config module, or compact UI + API slice |
| **$1.51 - 2.10$** | **3 Units** | Focused domain entity, service client, and webhook/handler slice |
| **$2.11 - 2.60$** | **4 Units** | Multi-endpoint resource or full-stack feature slice |
| **$2.61 - 3.10$** | **5 Units** | Standard complex user story (domain + operations + pagination/streams + edge cases) |
| **$3.11 - 3.55$** | **6–7 Units** | Large multi-component subsystem |
| **$> 3.55$** | **8+ Units (or Split Story)** | Very large story; either split into 8 orthogonal units or refactor into 2 User Stories |

## 3. Pure-Implementation & Non-Blocking Unit Invariant

1. **Every Unit Is an Implementation Unit**:
   - Each unit $u_i \in \{1..K\}$ MUST deliver production code plus its own unit tests.
   - **Prohibited**: Creating a "Unit $K$: Integration Tests & Validation for Units $1..K-1$" unit. Such a unit cannot run in parallel with Units $1..K-1$ and violates the non-blocking invariant.
2. **Zero Inter-Unit Blocking**:
   - Before spawning Unit Implementers $1..K$, the Story Leader defines shared types/interfaces on the story base branch (`feat/us-M.S.0-<slug>`) or partitions units into disjoint files/modules so all $K$ units compile, test, and run concurrently in parallel without waiting on one another.
