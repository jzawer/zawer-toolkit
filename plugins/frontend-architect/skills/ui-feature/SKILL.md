---
name: ui-feature
description: End-to-end workflow to design and build a UI feature - ensures design context and tokens exist, breaks the feature into components, specs new ones, builds them and loops through design review until approved. Use when the user asks to build a screen, page, flow or UI feature.
---

# UI feature workflow

Orchestrates the other skills of this plugin. Humans approve at the cheap
moments (breakdown and specs), not at the end.

## 1. Context

- `docs/agents/frontend.md` missing → tell the user to run `/setup-frontend-architect`
  and stop. Setup is user-invoked; you can't run it for them.
- `DESIGN.md` missing → call the Skill tool with "design-context".
- `design/tokens.json` missing → ask whether to call the Skill tool with
  "design-tokens" now or continue with the existing styles (record the decision).

## 2. Break down

List the components the feature needs. Dispatch the component scout as a subagent
with a fresh context window (in Claude Code the `frontend-architect:component-scout`
agent; elsewhere a general-purpose subagent told to follow
[../../agents/component-scout.md](../../agents/component-scout.md)) to classify each
one as **reuse**, **extend** or **new**.
Show the table to the user and **wait for confirmation**.

## 3. Spec

For each **extend** or **new** component, call the Skill tool with "component-spec".
Present all specs together and **wait for approval**.

## 4. Build

For each component, leaf components first, call the Skill tool with "ui-build".
Then compose the screen from them.

## 5. Review loop

Call the Skill tool with "design-review" for the feature.
- `CHANGES REQUESTED` → call the Skill tool with "ui-build" (it reads the review
  file) → call the Skill tool with "design-review" again.
- Maximum **3 iterations**. If still not approved, stop and show the user the
  remaining findings; a human decides.

## 6. Close

Summarize: components reused / extended / created, decisions taken (suggest an
ADR in the configured ADR path if a decision affects other teams), open findings,
and anything that needs a human designer's call.
