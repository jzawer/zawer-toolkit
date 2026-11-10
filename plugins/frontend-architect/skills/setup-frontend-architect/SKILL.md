---
name: setup-frontend-architect
description: "Configure this repo for the frontend-architect skills: stack, styling and tokens, components, workbench, quality tooling and quality bar. For a new project, helps choose the stack and records it as an ADR. Run once before first use of the other frontend-architect skills."
disable-model-invocation: true
---

# Setup frontend-architect

Scaffold the per-repo configuration the other frontend-architect skills read:
`docs/agents/frontend.md` plus a short `## Frontend architect` block in
`CLAUDE.md` or `AGENTS.md`.

This is a prompt-driven wizard, not a script. Explore, present what you found,
ask one section at a time, show a draft, then write.

## 1. Explore

Read whatever exists; don't assume:

- `package.json` (dependencies, devDependencies, scripts), lockfile (package manager),
  `tsconfig.json` (`strict`?), workspace files (`pnpm-workspace.yaml`, `turbo.json`, `nx.json`).
- Framework and meta-framework config: `next.config.*`, `nuxt.config.*`, `astro.config.*`,
  `vite.config.*`, `angular.json`, `svelte.config.*`, `remix.config.*`.
- Styling: `tailwind.config.*` or `@import "tailwindcss"`, `*.module.css`, styled-components /
  emotion / vanilla-extract / SCSS, existing theme or tokens files, Style Dictionary config.
- Components: where they live (`src/components`, `src/ui`, `packages/ui`...), base libraries
  (Radix, shadcn/ui, MUI, Headless UI, Angular Material...).
- Workbench: `.storybook/`, Ladle, Histoire.
- Tooling: Vitest/Jest, Testing Library, Playwright, `@axe-core/playwright`, ESLint, Stylelint, Prettier/Biome.
- Existing `docs/agents/frontend.md`, `DESIGN.md`, `design/`, `docs/adr/`.
- `CLAUDE.md` and `AGENTS.md`: does either exist? Is there already a `## Frontend architect` block?

Decide the mode:
- **Existing project**: there is a frontend in the repo. Detect, then confirm.
- **New project**: no frontend yet. Help choose, then record the decision.
- **Re-run**: `docs/agents/frontend.md` exists. Show it and ask only what the user wants to change.

## 2. Present findings and ask

Summarize what is present and what is missing in a short table. Then go through the
sections in order. **One section, one answer, then the next.**

Lead each section with the recommended answer so the user can accept it in a word.
Skip a section entirely when exploration already settled it unambiguously; just show
what you detected in the final draft.

**A. Stack.**
- Existing project: confirm framework, meta-framework, language, package manager.
- New project: ask up to three questions, one at a time: (1) what is being built
  (content site, web app behind login, mix), (2) does it need SEO or fast first load
  for anonymous users, (3) what the team already knows. Then recommend **one** stack
  with a one-line reason and one alternative with its trade-off. Prefer boring,
  well-supported choices with TypeScript strict. Record the choice as an ADR in
  `docs/adr/NNNN-frontend-stack.md` (Context, Options considered, Decision, Consequences).
  Offer to scaffold with the framework's official CLI, but run it only if the user says yes.

**B. Styling and tokens.** Styling approach (recommend what is already used; for new
projects, recommend Tailwind or CSS Modules depending on the team), and where generated
token output goes (CSS variables file or Tailwind theme). Recommend Style Dictionary
only if tokens will feed more than one platform.

**C. Components.** Components path, base or headless library, and whether there is a
design-system package. For a monorepo, which package is the design system.

**D. Workbench.** Recommend Storybook if none exists. Record the start command and URL.
If the user declines, record a demo route instead.

**E. Commands and tooling.** Record the exact commands for typecheck, lint, unit and
component tests, E2E/visual. List missing tools the review skills need (Playwright,
`@axe-core/playwright`) with the install command for the detected package manager.
Never install anything without an explicit yes.

**F. Quality bar.** Propose defaults and ask once whether to keep them:
WCAG 2.2 AA · viewports 375 / 768 / 1280 · light and dark themes ·
last two versions of evergreen browsers · no i18n.
If the user changes any, record the new value.

**G. Agents.** Which coding agents the team uses (Claude Code, GitHub Copilot, both).
This only decides which instructions file to edit in step 4 and whether to mention
the `install-into-project` script from the toolkit README.

## 3. Confirm

Show the user a draft of:
- `docs/agents/frontend.md`, filled from [frontend-config.md](./frontend-config.md).
  Use `TODO(confirm)` for anything unknown instead of guessing.
- The `## Frontend architect` block (step 4).
- The ADR, if one was written in section A.

Let the user edit before writing.

## 4. Write

Pick the instructions file:
- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists: create `AGENTS.md` when the team uses Copilot or both agents
  (both read it), otherwise ask the user which one to create.

Never create `AGENTS.md` when `CLAUDE.md` already exists, or the reverse.
If a `## Frontend architect` block exists, update it in place.

The block:

```markdown
## Frontend architect

[One line: framework, styling, workbench]. Stack, commands, paths and quality bar:
see `docs/agents/frontend.md`. Design intent: `DESIGN.md`. Design artifacts: `design/`.
```

Then write `docs/agents/frontend.md` and the ADR if any.

## 5. Done

Tell the user setup is complete and suggest the next step:
- No `DESIGN.md` → run the `design-context` skill.
- No tokens → run the `design-tokens` skill.
- Otherwise → `ui-feature` for the next screen.

Mention they can edit `docs/agents/frontend.md` by hand later; re-running this skill
is only needed to change the stack or start over.
