# Frontend config

Read by the frontend-architect skills. Edit by hand or re-run `/setup-frontend-architect`.

## Stack

- Framework:
- Meta-framework / rendering:
- Language: TypeScript (strict)
- Package manager:
- Monorepo: no <!-- or tool + apps/packages layout -->
- Stack decision: <!-- ADR link, if any -->

## Architecture

- Topology: modular monolith <!-- or microfrontends + composition --> (ADR: )
- Folder structure: feature-based <!-- feature-sliced | layered --> (ADR: )
- Boundary rules: none <!-- tool + config path, written by frontend-boundaries -->
- Rendering strategy: n/a <!-- ADR link, written by rendering-strategy -->
- Server state / data fetching:
- API contract:

## Component library

- Strategy: <!-- styled library | headless + tokens | web components | custom --> (ADR: )
- Shared library: none <!-- package path in the monorepo, or external package name -->
- Library source of truth for agents: <!-- Storybook URL, docs path, MCP server, registry -->
- App components path:
- Contribution to the library: <!-- who approves, how it is versioned -->
- Inventory: `design/inventory.md`

## Styling and tokens

- Styling approach:
- Tokens source: `design/tokens.json`
- Tokens output:
- Tokens build: <!-- command, or "none" -->

## Workbench

- Tool: Storybook
- Start command:
- URL:

## Commands

- Install:
- Typecheck:
- Lint:
- Unit / component tests:
- E2E / visual:

## Quality bar

- Accessibility: WCAG 2.2 AA
- Viewports: 375, 768, 1280
- Themes: light, dark
- Browsers: last two versions of evergreen browsers
- i18n: none
- Performance budgets: none <!-- config path, written by performance-budget -->

## Baselines

- UI drift baseline: none <!-- design/audits/baseline.json, written by ui-drift-audit -->
- Visual baseline: none <!-- tool + snapshots path, written by visual-baseline -->

## Paths

- Design intent: `DESIGN.md`
- Design artifacts: `design/`
- Component specs: `design/components/`
- Reviews: `design/reviews/`
- Audits: `design/audits/`
- ADRs: `docs/adr/`
