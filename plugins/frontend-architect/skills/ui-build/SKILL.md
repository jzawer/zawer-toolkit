---
name: ui-build
description: Implement a UI component or screen strictly from its spec in design/components/, using only semantic tokens and existing components, with a Storybook story for every variant and state. Use after component-spec, or to fix findings from a design review in design/reviews/.
---

# UI build

## Inputs

Required:
- `design/components/<name>.md`. If missing, stop and run `component-spec`.

Read if present:
- `design/reviews/<name>.md`: fix its **Blocker** and **Should fix** findings first.
- `DESIGN.md`, `design/tokens.json`, `design/inventory.md`.
- `AGENTS.md` / `CLAUDE.md` and two or three existing components, to copy the
  repo's conventions (file layout, styling approach, naming, test style).

## Rules

- Only semantic tokens. No raw colors, px spacing, font sizes or durations.
- Reuse components from the inventory; never re-create one that exists.
- Implement every state the spec marks as applicable, including loading,
  empty and error.
- Accessibility is part of the build, not a later pass: semantic elements first,
  ARIA only when needed, visible focus, labels.
- Do not add dependencies without asking.

## Stories

Write one story per variant and per applicable state. Make sure light/dark and
mobile (375px) / desktop (1280px) can be checked (Storybook globals or
viewport parameters). Stories are the contract `design-review` verifies.
If the repo has no Storybook, propose adding it, or fall back to a demo route
and tell the user.

## Finish

1. Run typecheck, lint and the component tests. Fix what fails.
2. Set the component status to `built` in `design/inventory.md`.
3. Do not approve your own visual work: tell the user the next step is
   `design-review` (or let `ui-feature` continue the loop).
