# Changelog

## frontend-architect 0.2.0

- New user-invoked skill `setup-frontend-architect`: wizard that detects or helps choose
  the stack (with ADR for new projects) and writes `docs/agents/frontend.md`.
- All skills read `docs/agents/frontend.md` instead of hardcoded viewports, commands and paths.
- Portable across Claude Code and GitHub Copilot: relative links instead of
  `${CLAUDE_PLUGIN_ROOT}`, skill chaining via the Skill tool, and a general-purpose
  subagent fallback when named agents are not available.
- New `scripts/install-into-project.sh` for cloud sessions and agents without plugin support.

## frontend-architect 0.1.0

- Skills: `ui-feature`, `design-context`, `design-tokens`, `component-spec`, `ui-build`, `design-review`.
- Agents: `component-scout`, `design-reviewer`, `a11y-auditor`.
