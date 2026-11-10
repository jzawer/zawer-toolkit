---
name: component-library-strategy
description: Decide the component library strategy for a frontend - styled library, headless primitives plus own tokens, web components or fully custom - and how a shared library is organized, versioned and contributed to across teams, then record it as an ADR and in docs/agents/frontend.md. Use when there is no component library decision, several competing libraries coexist, multiple teams need shared components, or the user asks which component library to use.
---

# Component library strategy

A shared component library is what keeps humans and AI agents inside one visual and
behavioral vocabulary. This skill helps decide, it does not impose a fixed answer.

## Before you start

Read `docs/agents/frontend.md` (stack, topology, monorepo, quality bar) and the latest
`design/audits/ui-drift-*.md` if any. If there is no audit and the codebase has UI,
suggest calling the Skill tool with "ui-drift-audit" first; continue if the user prefers.

## 1. Gather the forces (one question at a time, skip what you already know)

1. How many teams and apps will consume the components? One app, several apps, several
   frameworks?
2. How distinctive must the brand be? Internal tool, or product where look and feel matter?
3. Accessibility requirement (from config) and who will own accessibility fixes.
4. Is there anyone who can own a design system (people and time), or must it be low upkeep?
5. What exists today (from the audit): libraries in use, duplicates, how much to migrate.

## 2. Evaluate the options

| Option | Fits when | Watch out for |
|---|---|---|
| **Styled library** (e.g. MUI, Mantine, Ant Design, Angular Material, Vuetify) | Internal tools, speed first, low brand needs | Fighting the theme for custom brand; upgrade cost |
| **Headless primitives + own tokens** (e.g. Radix, React Aria, Base UI, Ark UI; shadcn/ui-style code you own) | Product UI with own brand, accessibility handled by primitives. **Default recommendation for product work** | You own the styled layer and its maintenance |
| **Web components** (e.g. Lit, Stencil) | Several frameworks must share components, e.g. heterogeneous microfrontends | SSR and framework integration friction |
| **Fully custom** | A dedicated design-system team and needs no library meets | Highest cost, accessibility is all on you |

Also score each option on **agent-friendliness**: the code is readable in the repo
(owned or vendored source, not a black box), strictly typed, every component has
stories as usage examples, and docs can be consumed by agents (workbench, docs files,
an MCP server or registry when the library offers one).

Recommend **one** option with its main risk, and one alternative with its trade-off.
If the options are close or the people involved disagree strongly, call the Skill tool
with "process-handoff" for situation `contested-decision` before recording the ADR.
Library names are examples: check that a candidate supports the project's framework
version before recommending it.

## 3. Decide the organization

- **Where it lives**: package in the monorepo (`packages/ui`), separate repo published
  as a package, or a folder in a single app (fine for one team).
- **Tiers**: what belongs in the shared library (generic, reusable, brand) vs app
  components (feature-specific compositions). Rule of thumb: promote to the library at
  the second real consumer, not before.
- **Versioning and release**: e.g. changesets with semver, and a changelog consumers read.
- **Contribution**: who approves additions, the minimum bar (spec, stories for all states,
  accessibility review), and how deprecations and migrations are announced.
- **Source of truth for agents**: where an agent looks to see what exists (Storybook URL,
  docs path, MCP server, registry).

## 4. Record

1. ADR `docs/adr/NNNN-component-library-strategy.md`: Context (forces, audit numbers),
   Options considered, Decision, Consequences, migration plan for duplicates if any.
2. Update the **Component library** section of `docs/agents/frontend.md`.
3. If there are duplicates, add a migration list to `design/inventory.md`
   (canonical component per role, components to deprecate).

## 5. Next steps

Suggest `design-tokens` if tokens are not in place, and `component-spec` for the first
components to add or consolidate in the library.
