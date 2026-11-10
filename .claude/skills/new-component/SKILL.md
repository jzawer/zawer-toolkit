---
name: new-component
description: Scaffold a new skill, agent or plugin in this dev-toolkit repo following its conventions, then validate it. Use when the user wants to add a skill, an agent or a new plugin to the toolkit.
---

# Add a component to the toolkit

This is a project skill: it only exists while working inside the dev-toolkit repo.

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

- **Skill**: `plugins/<plugin>/skills/<kebab-name>/SKILL.md` with frontmatter
  `name` and `description`. The description says what it does AND when to use it,
  with concrete trigger phrases. Optional supporting files (templates) live next to it
  and are referenced as `${CLAUDE_PLUGIN_ROOT}/skills/<name>/<file>`.
- **Agent**: `plugins/<plugin>/agents/<kebab-name>.md` with frontmatter `name`,
  `description`, `tools` (minimum needed; reviewers/auditors are read-only) and
  `model` (`haiku` for search/scouting, `inherit` otherwise). Body: role,
  inputs, steps, and an exact output format the caller can merge.
  Other components call it as `<plugin>:<agent-name>`.
- **Plugin**: `plugins/<name>/.claude-plugin/plugin.json` (name, version 0.1.0,
  description, author) and add an entry to `.claude-plugin/marketplace.json`.

## 3. Wire it

Update the skills that should call the new component, the plugin README table,
and `CHANGELOG.md`. Bump the plugin `version` (minor for new components,
patch for fixes).

## 4. Validate

Run `./scripts/validate.sh` and fix every error and warning.
Suggest a manual test: `claude --plugin-dir ./plugins/<plugin>` in a sample project.
