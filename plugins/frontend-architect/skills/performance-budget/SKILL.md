---
name: performance-budget
description: Define frontend performance budgets (JavaScript and CSS size per route or entry, Core Web Vitals targets such as LCP, INP and CLS) and enforce them in CI with tools like size-limit and Lighthouse CI, reporting the current state and the biggest offenders. Use when setting up a project, when bundles or pages feel slow, before adding heavy dependencies, or when the user mentions performance budgets or Core Web Vitals.
---

# Performance budget

## Before you start

Read `docs/agents/frontend.md`: stack, rendering strategy, build and E2E commands,
budgets path if any. If missing, tell the user to run `/setup-frontend-architect`.

## 1. Measure the current state

- Build the app with the configured command and measure JS and CSS per entry or route
  (compressed). Use the bundler's analyzer or stats when available.
- If the app can run locally, measure key routes with Lighthouse (mobile profile) for
  LCP, CLS and Total Blocking Time as a lab proxy for INP. Say that lab numbers are not
  field data.
- List the top offenders: largest dependencies, duplicated packages, routes without
  code splitting, unoptimized images and fonts.

## 2. Propose budgets

Start from the current numbers, not ideal ones, so CI is green on day one:
- Size budgets per entry/route: current size rounded up a little, with a target to
  reduce toward.
- Web Vitals targets at the "good" thresholds (LCP ≤ 2.5 s, INP ≤ 200 ms, CLS ≤ 0.1),
  checked on the routes that matter most (landing, main flow).
Confirm with the user.

## 3. Enforce

- **size-limit** (or the bundler's equivalent) for size budgets, as a script and CI step.
- **Lighthouse CI** with assertions for the key routes, if the app can be served in CI.
Ask before adding dependencies or CI steps. Record the config path under
**Performance budgets** in `docs/agents/frontend.md`.

## 4. Report

Current vs budget per entry and route, top offenders with a suggested fix each
(lazy-load, replace dependency, split route, image/font optimization), and which fixes
give the biggest win first.
