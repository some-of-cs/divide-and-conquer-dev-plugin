---
description: Run an independent Code Reviewing Council audit on a Pull Request (Gates G0, G1, G2 cloudflare/security-audit-skill, G-Complexity cyclomatic-complexity, G-Docs) and post the verdict directly to the GitHub PR conversation.
argument-hint: <pr-number>
---

# `/council-review` — Independent Code Reviewing Council Audit

Target Pull Request: `$ARGUMENTS`

1. Load `skills/code-review-council/SKILL.md`, `skills/security-audit/SKILL.md` (`cloudflare/security-audit-skill`), and `skills/cyclomatic-complexity/SKILL.md`.
2. Inspect the PR diff (`gh pr diff $ARGUMENTS`) and run the project's build, linter, formatter, and test suites.
3. Evaluate all 6 quality gates:
   - **Gate G0**: 0 build/compiler errors, 0 linter warnings, 100% formatter compliance.
   - **Gate G1**: All unit/integration tests pass ($\ge 90\%$ line, $\ge 85\%$ branch coverage).
   - **Gate G2 (`security-audit`)**: Full security audit across applicable attack classes, secret hygiene, constant-time crypto, and input bounds.
   - **Gate G-Complexity (`cyclomatic-complexity`)**: Measure per-function $CC = 1 + \sum \text{decision points}$ ($CC \le 6$ target, $CC \le 10$ ceiling, $CC > 15$ hard blocker, max nesting $\le 2$).
   - **Gate G-Docs**: Public API docstrings, examples, and README.
4. Post the complete audit report and `GATE G-REVIEW APPROVED` or `CHANGES REQUESTED` verdict directly to the GitHub PR conversation using `gh pr comment $ARGUMENTS --body-file <tmpfile>` (or `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/post-pr-report.sh review --pr $ARGUMENTS ...`).
5. If changes are requested on a Story or Module PR, instruct the Leader to spawn a dedicated **`patch-implementer`** subagent (`patch/*` branch & PR).
