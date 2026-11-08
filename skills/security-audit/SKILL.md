---
name: security-audit
description: Perform comprehensive, language-agnostic security, cryptographic, input-validation, and secret-hygiene audits for Gate G2 and post structured findings directly to GitHub PR conversations.
---

# Gate G2: Security & Cryptographic Audit Skill (`security-audit`)

Use this skill during implementation and **Code Reviewing Council** evaluations across all tiers (Unit, Patch, User Story, Module, and Whole-Codebase).

---

## 1. Mandatory Gate G2 Security Audit Checklist

Every Pull Request MUST be audited against the following 7 security domains before `gh pr merge`:

### 1. Secret Hygiene & Credential Protection
- **Zero Hardcoded Secrets**: No API keys, tokens, private keys, or passwords in source code, tests, or fixtures (use synthetic test stubs only).
- **Redaction on Debug/Logs**: Structs/classes holding credentials, tokens, or PII MUST redact sensitive fields (`[REDACTED]`) in `Debug`, `toString()`, `repr()`, and structured logger outputs.
- **Memory Zeroization (Where Supported)**: Zeroize secret buffers on drop/dispose in systems languages.

### 2. Cryptographic & Webhook Verification Invariants
- **Constant-Time Comparisons**: Always use constant-time equality (`subtle::ConstantTimeEq`, `crypto.timingSafeEqual`, `hmac.compare_digest`) when verifying HMACs, webhook signatures, or tokens. Standard `==` string comparison on MAC digests is a **Critical Blocker**.
- **Replay & Drift Guards**: Enforce strict timestamp tolerance windows (e.g., $\pm 300\text{s}$) on signed webhooks and requests.
- **Modern Algorithms Only**: Use SHA-256/SHA-512, AES-GCM, ChaCha20-Poly1305, Ed25519, or Argon2id. Reject MD5, SHA-1, ECB mode, or non-cryptographic PRNGs for security tokens.

### 3. Input Validation, Deserialization & DoS Bounds
- **Payload Size Limits**: Enforce explicit maximum body/frame sizes (e.g., 1 MB max webhook payload) before parsing or allocating buffers.
- **Safe Deserialization**: Reject untrusted polymorphic deserialization (`pickle`, unsafe YAML load, unvalidated `eval`).
- **Path & URL Sanitization**: Prevent path traversal (`../`) and Server-Side Request Forgery (SSRF) when constructing file paths or URLs from caller parameters.

### 4. Injection & Data Boundary Safety (OWASP Top 10)
- **SQL / NoSQL / Command Injection**: Require parameterized queries and argument-array process execution (never shell interpolation with user input).
- **XSS / CSRF / AuthZ**: Verify output encoding, CSRF tokens, and explicit object-level authorization checks.

### 5. Financial, Privacy & Statutory Compliance (When Applicable)
- **Zero Raw Card/PAN Storage (PCI-DSS 4.0)**: Never log, store, or accept raw Primary Account Numbers; require tokenized payment methods.
- **Minor Currency Units (ISO 4217)**: Represent monetary amounts as exact integer minor units (`i64` / `bigint`) or exact decimal types—never `f32`/`f64` floating-point numbers.
- **GDPR / Privacy**: Support data minimization and clean erasure paths.

---

## 2. Severity Classification & Merge Gate Rules

| Severity | Definition | Gate G2 Impact |
| :--- | :--- | :--- |
| **Critical / High** | Exploitable vulnerability, timing leak, hardcoded secret, injection, or missing auth check | **Immediate PR Blocker (`CHANGES REQUESTED`)** |
| **Medium** | Missing payload bound, unredacted debug field, floating-point currency, or weak error handling | **Immediate PR Blocker (`CHANGES REQUESTED`)** |
| **Low / Informational** | Defense-in-depth hardening suggestion | Fix in current PR or via `patch-implementer` |

---

## 3. Posting the Security Audit to the PR Conversation

Do **NOT** write local security report files in `.agents/reports/`. Always post the Security Audit directly to the GitHub PR conversation via `gh pr comment <PR> --body "..."` or `./scripts/post-pr-report.sh`.
