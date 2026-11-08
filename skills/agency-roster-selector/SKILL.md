---
name: agency-roster-selector
description: Select, filter, and enable specialist AI agents from the bundled msitarzewski/agency-agents catalog (all 18 divisions and 283 agents) tailored to any programming language, framework, or product domain.
---

# Agency Roster Selector Skill (`msitarzewski/agency-agents`)

The **`divide-and-conquer-dev-plugin`** is completely **language-, framework-, and product-agnostic**. In addition to the 7 core orchestration agents (`Module Leader`, `Story Leader`, `Unit Implementer`, `patch-implementer`, `Code Reviewer Council President`, `Git Workflow Master`, `Quota Sentinel`), users can enable **any combination of the 283 specialist agents** from [`https://github.com/msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents).

All 18 divisions and all 283 Antigravity-converted skills are bundled directly inside `agents/agency-catalog/`.

---

## 1. Available Divisions (All 18 Divisions / 283 Agents Allowed)

| Division Key | Display Name | Agent Examples |
| :--- | :--- | :--- |
| `engineering` | **Engineering** | `backend-architect`, `frontend-developer`, `ai-engineer`, `devops-automator`, `database-optimizer`, `rust-refactoring-specialist`, `software-architect`, `api-platform-engineer`, `data-engineer`, `mobile-app-builder`, `git-workflow-master`, `code-reviewer` |
| `security` | **Security** | `application-security-engineer`, `ai-generated-code-security-auditor`, `penetration-tester`, `cloud-security-architect`, `compliance-auditor`, `security-architect` |
| `testing` | **Testing** | `api-tester`, `performance-benchmarker`, `test-automation-engineer`, `reality-checker`, `accessibility-auditor`, `test-results-analyzer` |
| `product` | **Product** | `product-manager`, `dx-engineer`, `sprint-prioritizer`, `feedback-synthesizer`, `trend-researcher` |
| `design` | **Design** | `ui-designer`, `ux-researcher`, `ux-architect`, `brand-guardian`, `whimsy-injector` |
| `project-management` | **Project Management** | `project-shepherd`, `studio-operations`, `senior-project-manager`, `jira-workflow-steward` |
| `specialized` | **Specialized** | `agents-orchestrator`, `mcp-builder`, `workflow-architect`, `lsp-index-engineer`, `model-qa-specialist` |
| `game-development` | **Game Development** | `unity-architect`, `unreal-systems-engineer`, `godot-gameplay-scripter`, `roblox-systems-scripter`, `blender-add-on-engineer`, `level-designer` |
| `spatial-computing` | **Spatial Computing** | `xr-interface-architect`, `visionos-spatial-engineer`, `xr-immersive-developer` |
| `finance` | **Finance** | `financial-analyst`, `fp-a-analyst`, `investment-researcher`, `bookkeeper-controller`, `tax-strategist` |
| `healthcare` | **Healthcare** | `clinical-evidence-agent`, `healthcare-innovation-strategist`, `sovereign-health-systems-agent` |
| `gis` | **GIS** | `spatial-data-scientist`, `bim-gis-specialist`, `cartography-designer`, `geoai-ml-engineer` |
| `research` | **Research** | `research-synthesist` |
| `academic` | **Academic** | `anthropologist`, `statistician`, `historian`, `psychologist` |
| `marketing` | **Marketing** | `content-creator`, `growth-hacker`, `seo-specialist`, `developer-community-builder` |
| `paid-media` | **Paid Media** | `ppc-campaign-strategist`, `ad-creative-strategist`, `programmatic-display-buyer` |
| `sales` | **Sales** | `account-strategist`, `sales-engineer`, `proposal-strategist` |
| `support` | **Support** | `support-responder`, `infrastructure-maintainer`, `analytics-reporter` |

---

## 2. How to Select & Enable Agents for Your Project

Use `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh` to browse, filter, or install presets into your workspace's `.agents/agents/` and `.agents/skills/` directories:

```bash
# List all 18 divisions and agent counts
${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh --list-divisions

# Search agents by keyword (e.g., python, react, security, rust, kubernetes, game)
${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh --search "typescript"

# Enable all agents in specific divisions (e.g., engineering + security + testing)
${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh --divisions engineering,security,testing --target /path/to/your/project

# Enable specific individual agents by slug
${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh --agents backend-architect,frontend-developer,application-security-engineer,api-tester --target /path/to/your/project

# Enable ALL 283 agents from all 18 divisions
${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh --all --target /path/to/your/project
```

---

## 3. Mapping Selected Agents to the Divide-and-Conquer Tiers

When the user selects their project roster, the plugin automatically wires them into two roles:
1. **Unit & Patch Implementer Specialists**: Domain/language agents (e.g., `frontend-developer`, `backend-architect`, `ai-engineer`, `database-optimizer`, `unity-architect`) execute the parallel Implementation Units ($1..K$) and `patch-implementer` tasks.
2. **Code Reviewing Council Specialists**: Quality & governance agents (e.g., `code-reviewer`, `application-security-engineer`, `api-tester`, `performance-benchmarker`, `accessibility-auditor`) form the parallel **Code Reviewing Councils** armed with `security-audit` and `cyclomatic-complexity`.
