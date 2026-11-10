---
name: design-review
description: Review implemented UI against its spec, design tokens and DESIGN.md by running two independent reviewers in parallel (visual/design and accessibility) and merging their findings into design/reviews/. Use after ui-build, before merging UI changes, or when the user asks whether a component or screen looks right.
---

# Design review

The builder never approves its own work. This skill runs two reviewers with
fresh context and merges what they find.

## 1. Prepare

- Read `docs/agents/frontend.md` for the workbench command and URL, viewports,
  themes and accessibility level. If missing, tell the user to run
  `/setup-frontend-architect` and stop.
- Identify the component(s) or screen under review and their specs in
  `design/components/`.
- Start the workbench (or app) in the background with the configured command and
  check the URL responds. If it can't start, report why and stop.

## 2. Run both reviewers in parallel

Dispatch two subagents **at the same time**, each with a fresh context window.
Give each: component name, spec path, workbench URL, story IDs or routes, and the
viewports, themes and accessibility level from the config.

| Reviewer | Claude Code agent | Elsewhere: general-purpose subagent told to follow |
|---|---|---|
| Visual / design | `frontend-architect:design-reviewer` | [../../agents/design-reviewer.md](../../agents/design-reviewer.md) |
| Accessibility | `frontend-architect:a11y-auditor` | [../../agents/a11y-auditor.md](../../agents/a11y-auditor.md) |

When using the fallback, tell the subagent to ignore the file's frontmatter and
not to edit any source file.

## 3. Merge

Write `design/reviews/<component-or-feature>.md`:

```markdown
# Review: <name> (iteration N)

## Blocker
- [visual|a11y] Finding: evidence (screenshot / file:line), suggested fix

## Should fix
## Nice to have

## Acceptance criteria
- [x] / [ ] each criterion from the spec

Verdict: APPROVED | CHANGES REQUESTED
```

- Deduplicate findings both reviewers reported.
- Any Blocker, or any unmet acceptance criterion → `CHANGES REQUESTED`.
- If the file already exists, increment the iteration and keep the previous
  iteration below a `---` separator.

## 4. Report

Give the user the verdict and the Blockers in a few lines. If approved, set
the component status to `approved` in `design/inventory.md`, and if a visual baseline
is configured, offer to call the Skill tool with "visual-baseline" to add or update
its snapshots.
