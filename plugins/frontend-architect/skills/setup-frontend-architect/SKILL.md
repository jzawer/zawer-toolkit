---
name: setup-frontend-architect
description: "Configure this repo for the frontend-architect skills: tooling, frontend architecture decisions (as ADRs), component library strategy, and a health check of duplicated components and inconsistent styling. Run once before first use of the other frontend-architect skills."
disable-model-invocation: true
---

# Setup frontend-architect

Scaffold the per-repo configuration the other frontend-architect skills read:
`docs/agents/frontend.md`, architecture ADRs, a UI health baseline, and a short
`## Frontend architect` block in `CLAUDE.md` or `AGENTS.md`.

This is a prompt-driven wizard, not a script. Explore, present what you found,
ask one section at a time, show a draft, then write.

## 1. Explore

Read whatever exists; don't assume:

- `package.json` (dependencies, devDependencies, scripts), lockfile (package manager),
  `tsconfig.json` (`strict`?).
- Monorepo signals: `pnpm-workspace.yaml`, `workspaces` in `package.json`, `turbo.json`,
  `nx.json`, populated `apps/*` and `packages/*`. Note which package is an app and which
  looks like a component library or design system.
- Microfrontend signals: Module Federation config, single-spa, import maps, several apps
  composed at runtime.
- Framework and meta-framework config: `next.config.*`, `nuxt.config.*`, `astro.config.*`,
  `vite.config.*`, `angular.json`, `svelte.config.*`.
- Folder structure of the frontend source: feature folders, `features/` + `shared/`,
  Feature-Sliced layers (`app/ pages/ widgets/ features/ entities/ shared/`), or
  technical layers (`components/ hooks/ services/ utils/`).
- Styling: Tailwind, CSS Modules, CSS-in-JS, SCSS, theme or tokens files, Style Dictionary.
- Components: app components path, base or headless libraries (Radix, React Aria, Base UI,
  shadcn/ui, MUI, Mantine, Angular Material, Vuetify...), an internal component library
  package or external design-system dependency.
- Workbench (`.storybook/`, Ladle, Histoire) and tooling (Vitest/Jest, Testing Library,
  Playwright, `@axe-core/playwright`, ESLint, Stylelint, dependency-cruiser,
  `eslint-plugin-boundaries`, size-limit, Lighthouse CI).
- Existing `docs/agents/frontend.md`, `DESIGN.md`, `design/`, `docs/adr/`.
- `CLAUDE.md` and `AGENTS.md`: does either exist? Is there a `## Frontend architect` block?

Decide the mode:
- **Existing project**: detect, then confirm.
- **New project**: no frontend yet. Help choose, then record decisions as ADRs.
- **Re-run**: `docs/agents/frontend.md` exists. Show it and ask only what the user wants to change.

## 2. Health check (existing projects only)

Call the Skill tool with "ui-drift-audit" and the argument `quick`. It returns a few
numbers: hardcoded style values, likely duplicated components, competing patterns
(e.g. three modal implementations), styling approaches in use.

Show the numbers to the user in a short table. They inform the questions below
(e.g. many duplicates make the component library question urgent). Offer the full
audit at the end (step 6); don't run it now.

## 3. Ask: tooling (phase 1)

Summarize what you detected in a short table, then go section by section.
**One section, one answer, then the next.** Lead each section with the recommended
answer so the user can accept it in a word. Skip a section when exploration settled it
unambiguously; just show it in the final draft.

**A. Stack.** Existing project: confirm framework, meta-framework, language, package
manager, monorepo layout. New project: ask up to three questions, one at a time
((1) what is being built, (2) SEO / fast first load for anonymous users, (3) what the
team knows), recommend **one** stack with a one-line reason plus one alternative with
its trade-off, record it as `docs/adr/NNNN-frontend-stack.md`, and offer to scaffold
with the official CLI (only on an explicit yes).

**B. Styling and tokens.** Styling approach and where generated token output goes.

**C. Workbench.** Recommend Storybook if none exists; record start command and URL,
or a demo route if declined.

**D. Commands and tooling.** Exact commands for typecheck, lint, unit/component tests,
E2E/visual. List missing tools the quality skills need, with the install command for
the detected package manager. Never install anything without an explicit yes.

**E. Quality bar.** Propose and ask once: WCAG 2.2 AA · viewports 375 / 768 / 1280 ·
light and dark · last two versions of evergreen browsers · no i18n.

## 4. Ask: architecture (phase 2)

Each decision here becomes an ADR in the ADR path (`docs/adr/NNNN-<slug>.md`: Context,
Options considered, Decision, Consequences). For an existing project, a decision that
only confirms what is already there gets a short ADR marked "Recorded, not changed".

**F. Topology.** Don't ask "monolith or microfrontends?". Ask the question that decides it:
*"How many teams need to deploy parts of the frontend independently of each other?"*
- One team, or teams that release together → **modular monolith** (recommended default).
- Several teams with independent release cycles and clear product areas → microfrontends,
  and ask how they are composed (build time, server, runtime).
If microfrontends already exist, record them and ask whether they still pay off.

**G. Folder structure.** Recommend based on size and topology:
- **Feature-based** (`features/<feature>/`, `shared/`): recommended default.
- **Feature-Sliced Design**: large apps with many teams in one codebase.
- **Layered** (`components/ hooks/ services/`): small apps only.
For existing code, recommend converging on what is mostly used rather than a rewrite.
Then offer to call the Skill tool with "frontend-boundaries" to turn the choice into
lint rules (do it at the end, in step 6).

**H. Component library.** If there is no clear, single decision (no library, or the
health check found competing ones), call the Skill tool with "component-library-strategy".
Otherwise just confirm: strategy, shared library location, app components path, and how
contributions to the library are approved.

**I. Rendering and data.** Only when there is a meta-framework or SSR: offer to call the
Skill tool with "rendering-strategy" (step 6). Ask which server-state / data-fetching
library and API contract are used (OpenAPI types, tRPC, GraphQL, hand-written).

**J. Engineering process.** Detect whether an engineering-process plugin is installed
(Matt Pocock's skills: `to-spec` / `to-tickets` / `diagnosing-bugs` in your available
skills, or `docs/agents/issue-tracker.md`). Record it as **Process plugin**. If Matt's
skills are installed but `docs/agents/issue-tracker.md` is missing, tell the user to run
`/setup-matt-pocock-skills` too. This plugin never configures that one.

**K. Performance.** Ask whether to set performance budgets now (offer the
"performance-budget" skill in step 6) or later.

## 5. Confirm

Show the user a draft of:
- `docs/agents/frontend.md`, filled from [frontend-config.md](./frontend-config.md).
  Use `TODO(confirm)` for anything unknown instead of guessing.
- The ADR titles and their one-line decisions.
- The `## Frontend architect` block (below).

Let the user edit before writing.

## 6. Write and follow up

Pick the instructions file:
- If `CLAUDE.md` exists, edit it. Else if `AGENTS.md` exists, edit it.
- If neither exists: create `AGENTS.md` when the team uses Copilot or several agents,
  otherwise ask which one to create.
- Never create `AGENTS.md` when `CLAUDE.md` exists, or the reverse.
- Update an existing `## Frontend architect` block in place.

The block:

```markdown
## Frontend architect

[One line: framework, topology, folder structure, component library].
Stack, commands, architecture, paths and quality bar: see `docs/agents/frontend.md`.
Design intent: `DESIGN.md`. Design artifacts: `design/`. Decisions: the ADR path.
Reuse components from the component library before creating new ones.
```

Write `docs/agents/frontend.md` and the ADRs. Then run the follow-ups the user accepted,
one Skill tool call each: "frontend-boundaries", "rendering-strategy",
"performance-budget", and "ui-drift-audit" (full) if the health check found issues.

## 7. Done

Tell the user setup is complete, summarize the decisions in a few lines, and suggest
the next step:
- No `DESIGN.md` → the `design-context` skill.
- No tokens, or many hardcoded values → the `design-tokens` skill.
- Otherwise → `ui-feature` for the next screen.

Mention they can edit `docs/agents/frontend.md` by hand later; re-run this skill only to
change the stack or architecture, or to start over.
