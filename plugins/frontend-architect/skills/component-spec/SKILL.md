---
name: component-spec
description: Write a design spec for a UI component before implementing it - anatomy, variants, states, props API, tokens, responsive behavior and accessibility - after checking the component inventory to reuse or extend existing components. Use before building any new component, or when the user describes a UI element to create.
---

# Component spec

Designing on paper is the cheapest moment to change your mind. Never skip the
reuse check: duplicated components are the most common failure of AI-generated UI.

## Before you start

Read `docs/agents/frontend.md` (components path, base library, viewports, quality bar),
`DESIGN.md` and `design/tokens.json`. If the config is missing, tell the user to run
`/setup-frontend-architect`. If DESIGN.md or tokens are missing, say so and offer to
call the Skill tool with "design-context" or "design-tokens" first; continue with
explicit assumptions if the user prefers.

## 1. Check for reuse

Dispatch the **component scout** as a subagent with a fresh context window, giving
it a description of the needed component:
- In Claude Code, use the `frontend-architect:component-scout` agent.
- Elsewhere, use a general-purpose subagent and tell it to read and follow
  [../../agents/component-scout.md](../../agents/component-scout.md), ignoring its frontmatter.

It returns existing candidates and how well each fits.
- If a candidate covers ~80% of the need, propose **extending** it instead of
  creating a new one. Let the user decide.
- If `design/inventory.md` is missing, ask the scout to build it, and write it
  (one line per component: name, path, purpose, status).

## 2. Write the spec

Write `design/components/<component-name>.md` from [template.md](./template.md).

Rules:
- Variants only for real use cases that exist today.
- Prefer composition (children, slots, compound components) over a growing list
  of boolean props. Follow the conventions of the base library in the config.
- Every visual property references a **semantic** token. No raw values.
- If a WAI-ARIA Authoring Practices pattern applies (dialog, tabs, combobox,
  menu, disclosure...), name it and follow its keyboard model. If the base library
  already implements it, say so and reuse it.
- Responsive behavior for each configured viewport.
- Acceptance criteria must be verifiable by looking at a story or running a check.

## 3. Update the inventory

Add or update the component in `design/inventory.md` with status `specified`.

## 4. Ask for approval

Show the user a short summary (purpose, variants, API, open questions) and wait
for approval before anything is built.
