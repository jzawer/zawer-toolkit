---
name: design-review
description: Review implemented UI against its spec, design tokens and DESIGN.md by running two independent reviewer agents in parallel (visual/design and accessibility) and merging their findings into design/reviews/. Use after ui-build, before merging UI changes, or when the user asks whether a component or screen looks right.
---

# Design review

The builder never approves its own work. This skill runs two reviewers with
fresh context and merges what they find.

## 1. Prepare

- Identify the component(s) or screen under review and their specs in
  `design/components/`.
- Make sure there is something to look at: start Storybook (or the app dev
  server) in the background and note the URL. If it can't start, report why
  and stop.

## 2. Run both reviewers in parallel

Launch these agents **in the same message** so they run concurrently. Give each
the component name, spec path, the URL and the list of story IDs/routes:

- `frontend-architect:design-reviewer`: spec compliance, tokens, visual quality.
- `frontend-architect:a11y-auditor`: accessibility (axe, keyboard, semantics).

## 3. Merge

Write `design/reviews/<component-or-feature>.md`:

```markdown
# Review: <name> (iteration N)

## Blocker
- [visual|a11y] Finding — evidence (screenshot / file:line) — suggested fix

## Should fix
## Nice to have

## Acceptance criteria
- [x] / [ ] each criterion from the spec

Verdict: APPROVED | CHANGES REQUESTED
```

- Deduplicate findings both agents reported.
- Any Blocker, or any unmet acceptance criterion → `CHANGES REQUESTED`.
- If the file already exists, increment the iteration and keep the previous
  iteration below a `---` separator.

## 4. Report

Give the user the verdict and the Blockers in a few lines. If approved, set
the component status to `approved` in `design/inventory.md`.
