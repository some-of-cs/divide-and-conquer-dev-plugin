# Decomposition Walkthrough: Monolithic Docs $\to$ Modules $\to$ Stories $\to$ Dynamic $K$ Units

This guide demonstrates how the `spec-decomposition` skill transforms a monolithic specification into **Modules**, **User Stories**, and a **dynamically sized number of non-blocking Implementation Units ($K$)** using the **Unit Sizing Decision Matrix**.

---

## 1. Calculating $K$ with the Unit Sizing Decision Matrix

Recall the formula from `skills/spec-decomposition/SKILL.md`:

$$S_{\text{story}} = 0.35 D_1 (\text{Surface}) + 0.25 D_2 (\text{LOC}) + 0.20 D_3 (\text{Complexity}) + 0.20 D_4 (\text{Orthogonal Boundaries})$$

### Example A: Compact Story $\to$ $K = 2$ Implementation Units
- **Story**: *Webhook Signature Verification & Timestamp Drift Guard*
- **Scoring**:
  - $D_1 = 1$ (2 components: HMAC verifier + header parser)
  - $D_2 = 1$ ($\approx 240$ LOC)
  - $D_3 = 2$ (Constant-time comparison & drift window validation)
  - $D_4 = 1$ (2 independent files: `signature.rs`, `header.rs`)
- **Weighted Score**: $S_{\text{story}} = 0.35(1) + 0.25(1) + 0.20(2) + 0.20(1) = \mathbf{1.20} \implies \mathbf{K = 2\text{ Units}}$:
  - `unit-1-header-parser`: Parses `Stripe-Signature` header (`t=...,v1=...`) and enforces 1 MB payload guard + unit tests.
  - `unit-2-hmac-verifier`: Computes HMAC-SHA256, constant-time digest check, and 300s timestamp drift guard + unit tests.
  - *Both units are pure implementation slices and run 100% in parallel.*

### Example B: Medium Story $\to$ $K = 3$ Implementation Units
- **Story**: *API v2 Billing Meter Event Ingestion (REST, Batch & Async Stream)*
- **Scoring**:
  - $D_1 = 2$ (3 endpoints)
  - $D_2 = 2$ ($\approx 520$ LOC)
  - $D_3 = 2$ (RFC 3339 timestamps, idempotency keys, session tokens)
  - $D_4 = 2$ (3 decoupled modules)
- **Weighted Score**: $S_{\text{story}} = 0.35(2) + 0.25(2) + 0.20(2) + 0.20(2) = \mathbf{2.00} \implies \mathbf{K = 3\text{ Units}}$:
  - `unit-1-sync-meter-events`: Synchronous `/v2/billing/meter_event_sends` endpoint & DTOs + unit tests.
  - `unit-2-meter-event-sessions`: `/v2/billing/meter_event_sessions` authentication token lifecycle + unit tests.
  - `unit-3-meter-event-stream`: High-throughput `/v2/billing/meter_event_stream` batch ingestion + unit tests.

### Example C: Rich Domain Story $\to$ $K = 5$ Implementation Units (`some-stripe` US-8.2.0)
- **Story**: *US-8.2.0 — V2 Billing Meter Event Stream, Event Destinations & Core Account Links*
- **Scoring**:
  - $D_1 = 3$ (6 endpoints/entities across Billing & Core v2)
  - $D_2 = 3$ ($\approx 1,100$ LOC)
  - $D_3 = 3$ (Strict v2 JSON contract, zero-clone borrowing, secret redaction)
  - $D_4 = 3$ (5 orthogonal submodules)
- **Weighted Score**: $S_{\text{story}} = 0.35(3) + 0.25(3) + 0.20(3) + 0.20(3) = \mathbf{3.00} \implies \mathbf{K = 5\text{ Units}}$:
  - `unit-1`: Synchronous Meter Event Ingestion (`/v2/billing/meter_event_sends`)
  - `unit-2`: Meter Event Session & High-Throughput Stream (`/v2/billing/meter_event_stream`)
  - `unit-3`: V2 Event Destinations CRUD (`/v2/core/event_destinations`)
  - `unit-4`: V2 Event Destination Lifecycle Actions (`ping`, `disable`, `enable`)
  - `unit-5`: V2 Core Accounts & Account Links (`/v2/core/accounts`, `/v2/core/account_links`)

### Example D: Large Full-Stack Story $\to$ $K = 7$ Implementation Units
- **Story**: *Multi-Tenant Analytics Dashboard (Schema, Ingestion, Aggregation, Export, AuthZ, WebSockets, UI Widgets)*
- **Scoring**: $D_1 = 4, D_2 = 4, D_3 = 3, D_4 = 3 \implies S_{\text{story}} = \mathbf{3.55} \implies \mathbf{K = 7\text{ Units}}$ running concurrently in 7 isolated `.worktrees/`.
