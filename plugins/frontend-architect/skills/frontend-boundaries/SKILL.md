---
name: frontend-boundaries
description: Turn the frontend folder structure and topology (feature-based, Feature-Sliced Design, layered, monorepo packages, microfrontends) into enforceable dependency rules with dependency-cruiser or eslint-plugin-boundaries, wire them into lint and CI, and report current violations. Use after choosing a folder structure, when imports cross features or layers they shouldn't, or when the user asks to enforce architecture rules.
---

# Frontend boundaries

An architecture that lives only in documentation erodes, faster still when agents write
much of the code. This skill makes the structure checkable.

## Before you start

Read `docs/agents/frontend.md`: folder structure, topology, monorepo layout, shared
library, lint command. If missing, tell the user to run `/setup-frontend-architect`.

## 1. Derive the rules from the structure

Write the rules in plain language first and confirm them with the user.

- **Feature-based**: a feature may import `shared/` and its own files; features don't
  import each other's internals, only a feature's public entry (`features/x/index.ts`)
  if cross-feature use is allowed at all.
- **Feature-Sliced Design**: layers import only downward
  (`app → pages → widgets → features → entities → shared`); slices in the same layer
  don't import each other; only through a slice's public API.
- **Layered**: UI components don't import data access directly; utilities import nothing
  from UI.
- **Monorepo**: apps depend on packages, never the reverse; the shared library never
  imports from an app; no deep imports into another package's `src/`.
- **Microfrontends**: no source imports between microfrontends; only through the shared
  library or the agreed contracts (events, routes, shared types package).
- Always: no imports from the shared library's internals, only from its entry points.

## 2. Choose the tool

- **dependency-cruiser**: any JS/TS project, good reports and graphs. Default choice.
- **eslint-plugin-boundaries**: when the team wants violations in the editor as lint errors.
- In an Nx workspace, prefer its module boundary rules with tags.
Ask before adding a dependency.

## 3. Implement

Write the configuration, add a script (e.g. `lint:boundaries`) and include it in the lint
command or CI. Record the tool and config path under **Boundary rules** in
`docs/agents/frontend.md`.

## 4. Report current violations

Run the check. If there are existing violations, don't fix them all now:
- Group them by rule and by feature, with counts.
- Offer a baseline or allowlist of known violations so CI fails only on **new** ones,
  and list the top groups as refactoring candidates.

## 5. Record

If the rules encode a decision not yet in an ADR, add one to the ADR path. Tell the user
that `ui-build` and `design-review` will now treat boundary violations as Blockers.
