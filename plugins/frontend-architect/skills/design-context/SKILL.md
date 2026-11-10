---
name: design-context
description: Create or update DESIGN.md, the source of truth for product design intent - users, brand personality, design principles, visual references, anti-patterns and constraints. Use when starting UI work in a repo without DESIGN.md, when the user talks about brand, look and feel or design principles, or when another design skill needs it and it is missing.
---

# Design context

DESIGN.md is the contract every other design skill reads. Without it, generated UI
is generic. Keep it short, concrete and owned by humans.

## If DESIGN.md exists

Read it. Compare it with the current UI (styles, components). Ask the user only
about gaps or contradictions, then update it.

## If it does not exist

1. Inspect the existing UI first: global styles, theme files, component folder,
   Storybook. Note what already exists so you don't ask what the code answers.
2. Interview the user, **one question at a time**:
   1. Who uses the product, on which devices, in which context (rush, focus, mobile)?
   2. Three adjectives for the brand personality, and three it must NOT feel like.
   3. Reference products whose UI they admire, and what exactly they like in each.
   4. Density: data-dense tool, or airy marketing feel?
   5. Hard constraints: accessibility level (default WCAG 2.2 AA), browsers,
      dark mode, i18n / RTL.
3. Write DESIGN.md at the repo root using the template at
   `${CLAUDE_PLUGIN_ROOT}/skills/design-context/template.md`.

## Quality bar

- Under 150 lines.
- Each principle must be concrete enough to settle a dispute
  ("Show data before decoration"), never generic ("Be user friendly").
- Each principle has a "This means / This does not mean" pair.
- Mark anything the user didn't confirm as `TODO(confirm)`.
