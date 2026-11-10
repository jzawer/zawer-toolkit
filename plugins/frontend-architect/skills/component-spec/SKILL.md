---
name: component-spec
description: Write a design spec for a UI component before implementing it - anatomy, variants, states, props API, tokens, responsive behavior and accessibility - after checking the component inventory to reuse or extend existing components. Use before building any new component, or when the user describes a UI element to create.
---

# Component spec

Designing on paper is the cheapest moment to change your mind. Never skip the
inventory check: duplicated components are the most common failure of AI-generated UI.

## 1. Check for reuse

Launch the `frontend-architect:component-scout` agent with a description of the
needed component. It returns existing candidates and how well each fits.

- If a candidate covers ~80% of the need, propose **extending** it instead of
  creating a new one. Let the user decide.
- If `design/inventory.md` is missing, ask the scout to build it, and write it
  (one line per component: name, path, purpose, status).

## 2. Read context

`DESIGN.md` (principles, constraints) and `design/tokens.json`.
If either is missing, say so and suggest running `design-context` / `design-tokens`
first. You may continue with explicit assumptions if the user prefers.

## 3. Write the spec

Write `design/components/<component-name>.md` using the template at
`${CLAUDE_PLUGIN_ROOT}/skills/component-spec/template.md`.

Rules:
- Variants only for real use cases that exist today.
- Prefer composition (children, slots, compound components) over a growing list
  of boolean props.
- Every visual property references a **semantic** token. No raw values.
- If a WAI-ARIA Authoring Practices pattern applies (dialog, tabs, combobox,
  menu, disclosure...), name it and follow its keyboard model.
- Acceptance criteria must be verifiable by looking at a story or running a check.

## 4. Update the inventory

Add or update the component in `design/inventory.md` with status `specified`.

## 5. Ask for approval

Show the user a short summary (purpose, variants, API, open questions) and wait
for approval before anything is built.
