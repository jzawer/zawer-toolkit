---
name: process-handoff
description: Hand off work that falls outside frontend design and quality - a missing shared library component to build, a migration of duplicated components, a boundary refactor, a behavior bug, a contested architecture decision, or non-UI logic - to the team's engineering process. Writes a brief and tells the user exactly which command to run in the installed process plugin (such as Matt Pocock's skills), or gives generic steps when none is installed. Use when a frontend-architect skill finds work it should not do itself.
---

# Process handoff

frontend-architect owns design, visual quality and frontend architecture. Specs, tickets,
implementation flow and debugging belong to the team's engineering process. This skill is
the bridge: it never does the other side's work, it prepares it and says how to start it.

## 1. Identify the situation

The caller (or the user) names one of these:

| Situation | Typical source |
|---|---|
| `missing-shared-component` | `component-spec` decided a component belongs in the shared library and needs to be planned and built as tracked work |
| `library-migration` | `ui-drift-audit` found duplicate groups to consolidate into canonical components |
| `boundary-refactor` | `frontend-boundaries` found groups of violations to fix |
| `behavior-bug` | `design-review` or a reviewer found broken behavior (not visual), or a bug inside the shared library |
| `contested-decision` | An ADR (topology, library strategy, rendering) has no clear winner or strong disagreement |
| `logic-implementation` | `ui-build` needs non-UI logic (data transforms, hooks with rules, state machines) |

## 2. Detect the process plugin

Read **Process plugin** in `docs/agents/frontend.md`. If it is missing or says `detect`:
- **mattpocock-skills** if any of `to-spec`, `to-tickets`, `diagnosing-bugs` (or with the
  `mattpocock-skills:` prefix) is in your available skills, or `docs/agents/issue-tracker.md`
  exists.
- Otherwise **none**.

Then read the adapter: [adapters/mattpocock-skills.md](./adapters/mattpocock-skills.md) or
[adapters/generic.md](./adapters/generic.md).

## 3. Write the brief

Write `design/handoffs/YYYY-MM-DD-<slug>.md` and also show it in the conversation (some
process commands synthesize from the conversation, others take a file path):

```markdown
# Handoff: <title>

Situation: <situation>
Source: <spec / audit / review / ADR path>

## Problem
What is missing or wrong, from the user's or team's perspective.

## What is needed
The outcome, not the implementation steps.

## Constraints from frontend architecture
- Tier and contribution rules (library vs app), tokens only, boundary rules,
  quality bar (accessibility, viewports, themes), relevant ADRs.

## Acceptance criteria
- Verifiable items, including "passes design-review" for UI work.

## Out of scope
```

Keep it short: link to the spec, audit or review instead of copying them.

## 4. Tell the user what to run

Using the adapter, give the user **one recommended command** (and at most one alternative),
with the exact argument, in a code block. Commands of user-invoked skills can't be run
by you or by another skill: the user must type them. For model-invoked targets the adapter
marks as callable, you may offer to call the Skill tool with that name directly, and only
do it when the user agrees.

## 5. Close the loop

Note the handoff in the source artifact (a line in the spec, audit, review or ADR:
`Handoff: design/handoffs/<file>`), so the next frontend-architect run knows the work was
delegated and doesn't duplicate it. When the delegated work comes back as UI changes,
it goes through `design-review` like any other UI work.
