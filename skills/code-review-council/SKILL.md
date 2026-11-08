---
name: code-review-council
description: Conduct rigorous, independent multi-council code reviews enforcing Gate G0 (build/lint), Gate G1 (tests/coverage), Gate G2 (security-audit), Gate G-Complexity (cyclomatic-complexity), Gate G-Docs, and mandatory patch-implementer remediation with in-PR conversation reporting.
---

# Federated Code Reviewing Council Skill

Use this skill whenever acting as a **Code Reviewer** or **Council President** at the Unit, Patch, User Story, Module, or Whole-Codebase level.

---

## 1. Core Principles of the Code Reviewing Council

1. **Zero Self-Approval**:
   - An implementer or leader agent may NEVER approve its own Pull Request. Every PR requires an independent `Code Reviewer` subagent sign-off.
2. **Massive Parallelism (Multi-Council Execution)**:
   - Multiple Code Reviewing Councils run in parallel—one per implementation unit, patch, story, or module—so code review is never a serial bottleneck.
3. **Never Terminate Until Clean**:
   - If the Council finds any blocker, warning, security flaw, missing test, or function with Cyclomatic Complexity $CC > 10$, it posts a **`CHANGES REQUESTED`** report on the PR conversation.
   - At the Unit tier, the Unit Implementer fixes the issues and re-invokes the Council.
   - At the Story and Module tiers, the Leader spawns a dedicated **`patch-implementer`** subagent (`patch/us-M.S.0-<scope>` or `patch/module-M-<scope>`) to fix the issues via a patch PR and re-invokes the Council.
4. **100% In-Conversation PR Audit Trail**:
   - Every review iteration MUST be posted directly as a comment on the GitHub Pull Request via `gh pr comment <PR> --body "..."` (or `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/post-pr-report.sh`). Never write local report files.

---

## 2. The 6 Mandatory Quality Gates

| Gate | Name | Required Skill / Tooling | Pass Threshold |
| :--- | :--- | :--- | :--- |
| **Gate G0** | **Build, Linter & Formatter** | Project compiler, linter (`clippy`, `eslint`, `ruff`, `golangci-lint`, etc.), formatter | **0 errors, 0 warnings, 100% formatted** |
| **Gate G1** | **Tests & Coverage** | Unit, contract, & integration test suite | **100% passing; $\ge 90\%$ line & $\ge 85\%$ branch coverage** |
| **Gate G2** | **Security & Crypto Audit** | `security-audit` skill | **0 Critical/High/Medium vulnerabilities; 0 leaked secrets** |
| **Gate G-Complexity** | **Cyclomatic Complexity** | `cyclomatic-complexity` skill | **Target $CC \le 6$; Ceiling $CC \le 10$; Hard Blocker $CC > 15$** |
| **Gate G-Docs** | **Documentation & Examples** | Public API docs, runnable doctests/examples, `README.md` | **100% public symbols documented & verified** |
| **Gate G-Review** | **Council President Verdict** | `code-review-council` skill | **Structured sign-off comment posted on GitHub PR** |

---

## 3. Required PR Conversation Comment Template

Post the following markdown report directly to the PR conversation using `gh pr comment <PR_NUMBER> --body-file <tmpfile>`:

```markdown
### Gate G-Review & Gatekeeper Council Audit Report — [APPROVED / CHANGES REQUESTED]

- **PR**: #<PR_NUMBER> (`<branch-name>`)
- **Tier**: [Unit / Patch / User Story / Module / Whole-Codebase]
- **Commit Reviewed**: `<commit-sha>`

#### 1. Quality Gate Matrix
| Gate | Status | Evidence / Summary |
| :--- | :---: | :--- |
| **G0 (Build, Lint & Format)** | PASS / FAIL | `<verbatim command & exit code>` |
| **G1 (Tests & Coverage)** | PASS / FAIL | `<X passed, 0 failed>` |
| **G2 (Security Audit)** | PASS / FAIL | `0 vulnerabilities, secret redaction verified` |
| **G-Complexity (Cyclomatic)** | PASS / FAIL | `Max CC = X (<= 10 ceiling), Max nesting <= 2` |
| **G-Docs (API Docs & Examples)** | PASS / FAIL | `All public APIs documented & tested` |

#### 2. Cyclomatic Complexity Audit (`cyclomatic-complexity`)
| File | Function / Method | CC | Nesting Depth | Status |
| :--- | :--- | :---: | :---: | :---: |
| `path/to/file` | `function_name` | 3 | 1 | PASS (`<= 6`) |

#### 3. Security Audit Summary (`security-audit`)
- Input validation & payload bounds: Checked
- Secret handling & debug redaction: Checked
- Injection / auth / cryptography invariants: Checked

#### 4. Findings & Required Remediations
- None (0 blockers, 0 warnings).

#### Verdict
**GATE G-REVIEW APPROVED** — Cleared for `gh pr merge`.
```
