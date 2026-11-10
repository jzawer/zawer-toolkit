# zawer-toolkit: conventions for agents

This repo is a plugin marketplace (`.claude-plugin/marketplace.json`) read by
Claude Code and GitHub Copilot (CLI and VS Code). Plugins live in `plugins/<name>/`.

Keep every skill and agent portable across both harnesses:

- **Relative links** to files inside a skill folder (`[template.md](./template.md)`).
  Never `${CLAUDE_PLUGIN_ROOT}`: it only resolves in Claude Code.
- **Skill to skill**: write `call the Skill tool with "<name>"`, one skill per call.
  A user-invoked skill (`disable-model-invocation: true`, e.g. setup) can't be called by
  another skill: tell the user to run `/<name>` instead.
- **Skill to agent**: dispatch a subagent with a fresh context window. Name the Claude Code
  agent (`<plugin>:<agent>`) and give the fallback for other harnesses: a general-purpose
  subagent told to read and follow `../../agents/<agent>.md`, ignoring its frontmatter.
  This relative path also works after `scripts/install-into-project.sh` copies files.
- **Per-repo config**: skills read `docs/agents/<plugin-area>.md`, written by the plugin's
  setup skill. Never hardcode stack, commands, viewports or paths in a skill.
- **Contracts are files** with a known format (`DESIGN.md`, `design/...`). Document who
  writes and who reads each one in the plugin README.
- Reviewer and auditor agents are read-only and return a fixed Markdown format that the
  calling skill merges.

When you add or change a component: update the plugin README, `CHANGELOG.md`, bump the
plugin `version` (minor for new components, patch for fixes) and run `scripts/validate.sh`.
The project skill `.claude/skills/new-component` walks through this.
