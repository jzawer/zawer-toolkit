---
name: ui-build
description: Implement a UI component or screen strictly from its spec in design/components/, using only semantic tokens and existing components, with a workbench story for every variant and state. Use after component-spec, or to fix findings from a design review in design/reviews/.
---

# UI build

## Inputs

Required:
- `docs/agents/frontend.md`: stack, styling approach, components path, workbench and
  commands. If missing, tell the user to run `/setup-frontend-architect` and stop.
- `design/components/<name>.md`. If missing, call the Skill tool with "component-spec" first.

Read if present:
- `design/reviews/<name>.md`: fix its **Blocker** and **Should fix** findings first.
- `DESIGN.md`, `design/tokens.json`, `design/inventory.md`.
- Two or three existing components, to copy the repo's conventions
  (file layout, naming, test style).

## Rules

- Only semantic tokens. No raw colors, px spacing, font sizes or durations.
- Reuse components from the inventory and the base library; never re-create one that exists.
- Implement every state the spec marks as applicable, including loading,
  empty and error.
- Accessibility is part of the build, not a later pass: semantic elements first,
  ARIA only when needed, visible focus, labels.
- Do not add dependencies without asking.

## Stories

In the configured workbench, write one story per variant and per applicable state.
Make sure every configured theme and viewport can be checked (globals or viewport
parameters). Stories are the contract `design-review` verifies. If the config
records a demo route instead of a workbench, add the states there.

## Finish

1. Run the configured typecheck, lint and test commands. Fix what fails.
2. Set the component status to `built` in `design/inventory.md`.
3. Do not approve your own visual work: tell the user the next step is the
   `design-review` skill (or let `ui-feature` continue the loop).
