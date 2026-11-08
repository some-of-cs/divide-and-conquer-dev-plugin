---
name: agency-roster-selector
description: Select, filter, and enable specialist AI agents from the bundled msitarzewski/agency-agents catalog (all 18 divisions and 283 agents) tailored to any programming language, framework, or product domain.
---

# Agency Roster Selector Skill (`msitarzewski/agency-agents`)

The **`divide-and-conqure-dev-plugin`** is completely **language-, framework-, and product-agnostic**. In addition to the 7 core orchestration agents (`Module Leader`, `Story Leader`, `Unit Implementer`, `patch-implementer`, `Code Reviewer Council President`, `Git Workflow Master`, `Quota Sentinel`), users can enable **any combination of the 283 specialist agents** from [`https://github.com/msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents).

All 18 divisions and all 283 Antigravity-converted skills are bundled directly inside `agents/agency-catalog/`.

---

## 1. Available Divisions (All 18 Divisions / 283 Agents Allowed)

| Division Key | Display Name | Agent Examples |
| :--- | :--- | :--- |
| `engineering` | **Engineering** | `backend-architect`, `frontend-developer`, `ai-engineer`, `devops-automator`, `database-optimizer`, `rust-pro`, `python-pro`, `typescript-pro`, `golang-pro`, `mobile-app-builder`, `git-workflow-master`, `code-reviewer` |
| `security` | **Security** | `application-security-engineer`, `ai-generated-code-security-auditor`, `penetration-tester`, `cloud-security-architect`, `compliance-auditor`, `cryptography-engineer` |
| `testing` | **Testing** | `api-tester`, `performance-benchmarker`, `qa-automation-engineer`, `chaos-engineer`, `accessibility-auditor`, `test-results-analyzer` |
| `product` | **Product** | `product-manager`, `technical-product-manager`, `sprint-prioritizer`, `feedback-synthesizer`, `trend-researcher` |
| `design` | **Design** | `ui-designer`, `ux-researcher`, `design-system-architect`, `brand-guardian`, `whimsy-injector` |
| `project-management` | **Project Management** | `project-shepherd`, `studio-operations`, `agile-scrum-master`, `delivery-director` |
| `specialized` | **Specialized** | `agents-orchestrator`, `mcp-builder`, `prompt-engineer`, `knowledge-graph-engineer`, `data-engineer` |
| `game-development` | **Game Development** | Unity, Unreal, Godot, Roblox, Blender, 3D scene & shader specialists |
| `spatial-computing` | **Spatial Computing** | `xr-interface-architect`, `visionos-engineer`, `webxr-developer` |
| `finance` | **Finance** | `financial-analyst`, `quant-developer`, `fintech-compliance-specialist`, `accounts-payable-agent` |
| `healthcare` | **Healthcare** | `clinical-informatics-specialist`, `hipaa-compliance-architect`, `hl7-fhir-integrator` |
| `gis` | **GIS** | `geospatial-data-scientist`, `bim-gis-specialist`, `cartographic-designer` |
| `research` | **Research** | `deep-research-synthesizer`, `competitive-intelligence-analyst`, `patent-researcher` |
| `academic` | **Academic** | `anthropologist`, `literature-review-architect`, `statistical-methodology-advisor` |
| `marketing` | **Marketing** | `content-creator`, `growth-hacker`, `seo-strategist`, `developer-advocate` |
| `paid-media` | **Paid Media** | `ppc-campaign-strategist`, `ad-creative-strategist`, `programmatic-buyer` |
| `sales` | **Sales** | `account-strategist`, `solutions-architect`, `proposal-writer` |
| `support` | **Support** | `support-responder`, `incident-commander`, `customer-success-manager` |

---

## 2. How to Select & Enable Agents for Your Project

Use `./scripts/select-agents.sh` to browse, filter, or install presets into your workspace's `.agents/agents/` and `.agents/skills/` directories:

```bash
# List all 18 divisions and agent counts
./scripts/select-agents.sh --list-divisions

# Search agents by keyword (e.g., python, react, security, rust, kubernetes, game)
./scripts/select-agents.sh --search "typescript"

# Enable all agents in specific divisions (e.g., engineering + security + testing)
./scripts/select-agents.sh --divisions engineering,security,testing --target /path/to/your/project

# Enable specific individual agents by slug
./scripts/select-agents.sh --agents backend-architect,frontend-developer,application-security-engineer,api-tester --target /path/to/your/project

# Enable ALL 283 agents from all 18 divisions
./scripts/select-agents.sh --all --target /path/to/your/project
```

---

## 3. Mapping Selected Agents to the Divide-and-Conquer Tiers

When the user selects their project roster, the plugin automatically wires them into two roles:
1. **Unit & Patch Implementer Specialists**: Domain/language agents (e.g., `frontend-developer`, `backend-architect`, `ai-engineer`, `database-optimizer`, `unity-architect`) execute the parallel Implementation Units ($1..K$) and `patch-implementer` tasks.
2. **Code Reviewing Council Specialists**: Quality & governance agents (e.g., `code-reviewer`, `application-security-engineer`, `api-tester`, `performance-benchmarker`, `accessibility-auditor`) form the parallel **Code Reviewing Councils** armed with `security-audit` and `cyclomatic-complexity`.
