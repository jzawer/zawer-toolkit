---
name: new-component
description: Scaffold a new skill, agent or plugin in this zawer-toolkit repo following its conventions, then validate it. Use when the user wants to add a skill, an agent or a new plugin to the toolkit.
---

# Add a component to the toolkit

This is a project skill: it only exists while working inside the zawer-toolkit repo.

## 1. Clarify (one question at a time)

- What kind: **skill** (instructions Claude follows in the main conversation),
  **agent** (independent worker with its own context and restricted tools) or
  a **new plugin** (a separate group of skills/agents for another domain)?
  Rule of thumb: use an agent when the work should be independent from the
  builder (reviews, audits), is read-heavy and would flood the main context,
  or can run in parallel. Otherwise, a skill.
- Which plugin does it belong to (`plugins/<name>`)?
- What triggers it? Which files does it read and write (its contract)?
- Which existing skills/agents does it call or get called by?

## 2. Scaffold

Read `AGENTS.md` first and follow its portability conventions (relative links,
Skill tool chaining, subagent fallback, per-repo config).

- **Skill**: `plugins/<plugin>/skills/<kebab-name>/SKILL.md` with frontmatter
  `name` and `description`.
  - Model-invoked (default): the description says what it does AND when to use it,
    with concrete trigger phrases.
  - User-invoked (setup, destructive or one-off flows): add
    `disable-model-invocation: true` and write a short human-facing description.
  - Start with a "Before you start" step that reads the plugin's per-repo config
    (`docs/agents/<area>.md`) and points to the setup skill when it is missing.
  - Supporting files (templates) live next to it, linked as `[file.md](./file.md)`.
  - If the skill needs new per-repo settings, add them to the setup skill's wizard
    and config template instead of hardcoding them.
- **Agent**: `plugins/<plugin>/agents/<kebab-name>.md` with frontmatter `name`,
  `description`, `tools` (minimum needed; reviewers/auditors are read-only) and
  `model` (`haiku` for search/scouting, `inherit` otherwise). Body: role,
  inputs, steps, and an exact output format the caller can merge.
  Skills dispatch it as `<plugin>:<agent-name>` with the general-purpose fallback.
- **Plugin**: `plugins/<name>/.claude-plugin/plugin.json` (name, version 0.1.0,
  description, author), a `setup-<name>` skill if it needs per-repo config, and an
  entry in `.claude-plugin/marketplace.json`.

## 3. Wire it

Update the skills that should call the new component, the plugin README table,
and `CHANGELOG.md`. Bump the plugin `version` (minor for new components,
patch for fixes).

## 4. Validate

Run `./scripts/validate.sh` and fix every error and warning.
Suggest a manual test: `claude --plugin-dir ./plugins/<plugin>` in a sample project.
