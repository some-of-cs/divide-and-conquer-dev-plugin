---
description: Browse, search, and enable specialist AI agents from the bundled msitarzewski/agency-agents catalog (all 18 divisions and 283 agents) for your project.
argument-hint: [--list-divisions | --search <keyword> | --divisions <d1,d2> | --agents <a1,a2> | --all]
---

# `/select-agents` — Configure Your Project's Specialist Agent Roster

Arguments: `$ARGUMENTS`

1. Load `skills/agency-roster-selector/SKILL.md`.
2. Run `${CLAUDE_PLUGIN_ROOT:-${ANTIGRAVITY_PLUGIN_ROOT:-.}}/scripts/select-agents.sh $ARGUMENTS` to list divisions, search the 283 bundled agents from [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents), or enable the chosen agents into the current workspace.
