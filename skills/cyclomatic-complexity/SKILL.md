---
name: cyclomatic-complexity
description: Measure a function's branching complexity (CC = 1 + decision points) across any programming language and refactor high-complexity code so logic stays readable, testable, and compliant with Gate G-Complexity.
---

# Cyclomatic Complexity Minimization Skill (Gate G-Complexity)

Cyclomatic Complexity ($CC$) counts the number of linearly independent execution paths through a function. Every Unit Implementer, `patch-implementer`, and Code Reviewing Council MUST evaluate $CC$ on all new and modified functions.

---

## 1. Formula: $CC = 1 + \text{Decision Points}$

Start at **`1`**, then add **`+1`** for every branching construct in the target language:

| Construct Category | Examples Across Languages (Rust, TS/JS, Python, Go, Java, C#, C++) | Count |
| :--- | :--- | :---: |
| **Conditional Branches** | `if`, `else if` / `elif`, `if let`, `let ... else`, ternary `? :` | `+1` each |
| **Pattern / Switch Arms** | Each non-default `match` arm, `case` branch, or pattern guard (`if cond`) | `+1` per non-default arm |
| **Loops** | `for`, `while`, `while let`, `do ... while`, comprehension `if` filters | `+1` each |
| **Short-Circuit Boolean Ops** | `&&` (`and`), `\|\|` (`or`), nullish coalescing with fallback logic (`??`) | `+1` per operator |
| **Error / Exception Branches** | `catch` / `except` blocks, `?` / `try` early-error propagation where recovery logic branches | `+1` per handler |

*(Note: `else` and `default` / `_ =>` catch-all arms do **not** add `+1` because they share the branch opened by `if` or `switch`/`match`.)*

---

## 2. Gate G-Complexity Thresholds

| Complexity Range | Rating | Action Required |
| :---: | :--- | :--- |
| **$CC \in [1, 6]$** | **Ideal (Green)** | Clean, focused, easily testable. Ready for review. |
| **$CC \in [7, 10]$** | **Acceptable Ceiling (Yellow)** | Permitted only if nesting depth $\le 2$ and flow is linear. |
| **$CC \in [11, 15]$** | **Refactor Required (Orange)** | **Must decompose before PR merge.** Split into helper functions or table dispatch. |
| **$CC > 15$** | **Hard Merge Blocker (Red)** | **Gate G-Complexity FAILURE.** Blocks `gh pr merge` immediately. |

### Structural Invariants
- **Maximum Nesting Depth**: $\le 2$ levels inside any function body.
- **Single Level of Abstraction**: Coordinator functions orchestrate steps; leaf functions compute rules or predicates.

---

## 3. Five Proven Complexity-Reduction Patterns

### Pattern 1: Guard Clauses (Flatten Deep Nesting)
Replace nested `if { if { if { ... } } }` pyramids with early returns at the top of the function:
```typescript
// BEFORE (Nested, CC = 5, Depth = 3)
function processOrder(order?: Order): Result {
  if (order) {
    if (order.items.length > 0) {
      if (order.isPaid) {
        return fulfill(order);
      }
    }
  }
  return reject();
}

// AFTER (Flat Guard Clauses, CC = 4, Depth = 1)
function processOrder(order?: Order): Result {
  if (!order || order.items.length === 0 || !order.isPaid) {
    return reject();
  }
  return fulfill(order);
}
```

### Pattern 2: Extract Named Predicate Helpers
Move compound boolean expressions (`a && b || c && d`) into descriptive predicate functions (`isEligibleForRetry(req)`), reducing the caller's $CC$ and making the predicate independently unit-testable.

### Pattern 3: Replace Long `switch` / `if-else` Chains with Table / Map Dispatch
When branching selects data or a handler by key/type, replace an $N$-branch `switch` ($CC = N$) with a static lookup table or dictionary ($CC = 2$).

### Pattern 4: Separate Validation, Transformation, and I/O
Split monolithic functions that validate input, transform domain models, and perform network/database I/O into three composable functions (`validate_request`, `build_payload`, `execute_call`), each with $CC \le 4$.

### Pattern 5: Polymorphism / Strategy Pattern
Replace repeated type-tag branching across multiple functions with a trait, interface, or strategy method implementation.
