---
name: rendering-strategy
description: Decide the rendering strategy per route group of a web app - CSR, SSR, SSG, ISR or revalidation, streaming, islands or partial hydration - based on SEO, data freshness, personalization, interactivity and infrastructure cost, and record it as an ADR. Use when creating routes, choosing or migrating a meta-framework, or when the user asks about SSR vs CSR or slow first loads.
---

# Rendering strategy

## Before you start

Read `docs/agents/frontend.md` (stack, meta-framework, topology, performance budgets).
If missing, tell the user to run `/setup-frontend-architect`.

## 1. Inventory routes

List the app's routes from the router config or file-based routes, grouped by area.
For each group, ask or infer:
- SEO or social previews needed? (public vs behind login)
- Data freshness: static, minutes, per request, real time?
- Personalized per user?
- Interactivity: mostly content, or app-like?
- Traffic expectations.

## 2. Classify

Fill a table: route group × (SEO, freshness, personalization, interactivity) → strategy.
Default heuristics, to challenge when constraints say otherwise:
- Public, rarely changing → SSG.
- Public, changes every few minutes → ISR / cached with revalidation.
- Public, personalized or per-request data → SSR, streaming the slow parts.
- Behind login, app-like → CSR, or an SSR shell with client data fetching.
- Mostly static with small interactive parts → islands / partial hydration.
Only recommend strategies the configured meta-framework supports; say when a strategy
would require changing framework.

## 3. Consequences

For the chosen mix: hosting needs (static CDN vs server or edge), caching and
invalidation, cost, effect on Core Web Vitals, and on the performance budgets if any.

## 4. Record

Write `docs/adr/NNNN-rendering-strategy.md` with the table, the decision per route
group, and what would make us revisit it. Link it under **Rendering strategy** in
`docs/agents/frontend.md`.
