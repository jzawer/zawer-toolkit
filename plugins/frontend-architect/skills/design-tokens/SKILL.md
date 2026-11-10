---
name: design-tokens
description: Define, extract or audit design tokens (color, typography, spacing, radius, shadow, motion) in design/tokens.json using the W3C Design Tokens (DTCG) format, and generate the platform output such as CSS variables or a Tailwind theme. Use when setting up a design system, when hardcoded colors or spacing appear in code, or when the user mentions tokens, theming or dark mode.
---

# Design tokens

## 1. Audit the current state

Search the codebase for hardcoded values: hex/rgb/hsl colors, px/rem spacing,
font sizes, line heights, z-index, durations and easings. Group duplicates and
near-duplicates (e.g. `#1a73e8` vs `#1a74e8`, `15px` vs `16px`) and count usages.

## 2. Define tokens in two tiers

- **Primitive**: raw palette and scales (`color.blue.500`, `space.4`, `font.size.300`).
- **Semantic**: intent-based, the only tier components may use
  (`color.text.muted`, `color.surface.raised`, `color.border.focus`, `space.inset.md`).

Rules:
- Every semantic color token has a light and a dark value.
- Check every text/background semantic pair for WCAG AA contrast
  (4.5:1 normal text, 3:1 large text and UI components). Report failures.
- Prefer a small scale (e.g. 8–10 spacing steps) over matching every legacy value.
  List the legacy values you collapsed so the user can confirm.

## 3. Write and generate

1. Write `design/tokens.json` in DTCG format (`$value`, `$type`, aliases with `{...}`).
2. Generate platform output with the repo's existing tooling. If there is none,
   propose Style Dictionary and ask before adding dependencies.
3. Do not mass-replace hardcoded values in components without asking: propose
   the replacement plan first (by folder or component) and apply it in batches.

## 4. Protect

Propose a lint rule (stylelint `color-no-hex` / `declaration-property-value-disallowed-list`,
or an ESLint rule for CSS-in-JS / Tailwind arbitrary values) that forbids raw values
outside the generated tokens. Ask before adding it.

## 5. Report

Tokens created · hardcoded values replaced / pending · contrast failures ·
values that need a design decision from a human.
