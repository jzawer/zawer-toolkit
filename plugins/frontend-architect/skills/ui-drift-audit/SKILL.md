---
name: ui-drift-audit
description: Audit a frontend codebase for UI drift - duplicated or near-duplicate components, hardcoded style values that bypass tokens, competing implementations of the same pattern (modals, buttons, forms, toasts) and mixed styling approaches - and produce a prioritized report plus a numeric baseline that CI can hold steady. Use when the user asks how consistent the UI is, mentions duplicated components or inconsistent styles, before creating a component library, or with the argument "quick" for a numbers-only health check.
---

# UI drift audit

Measures how far the UI has drifted from a common system, so decisions about tokens
and the component library rest on numbers, not impressions.

## Before you start

Read `docs/agents/frontend.md` if it exists (components path, shared library, styling
approach, tokens output). It may not exist yet: the setup wizard calls this skill in
`quick` mode before writing it, so detect paths yourself when it is missing.

## Mode

- **quick** (argument `quick`): numbers only, no report file, no baseline. Target a
  couple of minutes. Run the scans yourself with Grep/Glob, no subagents.
- **full** (default): the steps below.

## 1. Scan in parallel

Dispatch three scanners at the same time, each a subagent with a fresh context window:
- In Claude Code, the `frontend-architect:ui-drift-scanner` agent.
- Elsewhere, a general-purpose subagent told to read and follow
  [../../agents/ui-drift-scanner.md](../../agents/ui-drift-scanner.md), ignoring its frontmatter.

Give each the paths to scan and one focus:

| Focus | Finds |
|---|---|
| `values` | Hardcoded colors, spacing, font sizes, radii, shadows, z-index, durations; arbitrary Tailwind values; near-duplicate values |
| `components` | Duplicated and near-duplicate components (same role, different name or path), components that re-implement the shared library |
| `patterns` | Competing implementations of the same UI pattern, and mixed styling approaches |

## 2. Merge and prioritize

Rank each finding by **impact × spread**:
- Impact: accessibility or behavior differences (e.g. one modal traps focus, another
  doesn't) rank above purely visual differences.
- Spread: number of usages and number of features or teams affected.

For each duplicate group, propose the **canonical** candidate (best accessibility, most
used, closest to the tokens) and the migration path for the others.

## 3. Write the report

`design/audits/ui-drift-YYYY-MM-DD.md`:

```markdown
# UI drift audit — YYYY-MM-DD

## Summary
| Metric | Value |
|---|---|
| Hardcoded style values | 0 |
| Duplicate component groups | 0 (0 components) |
| Competing patterns | 0 |
| Styling approaches in use | 0 |

## Top 10 actions (impact × spread)
1. ...

## Duplicate components
### <Role> — canonical: <Name> (<path>)
| Component | Path | Usages | Differences vs canonical |

## Competing patterns
## Hardcoded values (grouped, with suggested token)
## Styling approaches
```

## 4. Baseline

Write `design/audits/baseline.json` with the summary metrics and the date. Offer a CI
**ratchet**: a check that fails when a metric goes up compared with the baseline, and
updates the baseline when it goes down. Propose the script and CI step; add them only
on an explicit yes. Record the baseline path in `docs/agents/frontend.md`.

## 5. Feed the other skills

- Add each duplicate group to `design/inventory.md`, marking the canonical component and
  the ones to migrate (`status: deprecated → <canonical>`).
- Suggest next steps: `design-tokens` when hardcoded values dominate,
  `component-library-strategy` when duplicates or competing libraries dominate.
- To plan the consolidation of duplicate groups as tracked work, call the Skill tool with
  "process-handoff" for situation `library-migration`.
