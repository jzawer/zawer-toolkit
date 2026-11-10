# Changelog

## frontend-architect 0.3.0

- Setup wizard: UI health check (quick drift audit), tooling phase and an architecture phase
  (topology, folder structure, component library, rendering and data, performance) where each
  decision becomes an ADR.
- New skills: `ui-drift-audit` (with CI ratchet baseline), `component-library-strategy`,
  `frontend-boundaries`, `rendering-strategy`, `performance-budget`, `visual-baseline`.
- New agent: `ui-drift-scanner`.
- Two-tier components (shared library vs app): scout searches the library first, specs decide
  the tier and mark library contributions, build follows contribution and boundary rules.
- Design review flags boundary violations and re-implemented library components, and offers
  a visual baseline on approval.

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
