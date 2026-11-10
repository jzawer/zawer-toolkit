---
name: ui-feature
description: End-to-end workflow to design and build a UI feature - ensures design context and tokens exist, breaks the feature into components, specs new ones, builds them and loops through design review until approved. Use when the user asks to build a screen, page, flow or UI feature.
---

# UI feature workflow

Orchestrates the other skills of this plugin. Humans approve at the cheap
moments (breakdown and specs), not at the end.

## 1. Context

- `DESIGN.md` missing → run `design-context`.
- `design/tokens.json` missing → ask whether to run `design-tokens` now or
  continue with the existing styles (record the decision).

## 2. Break down

List the components the feature needs. Launch `frontend-architect:component-scout`
to classify each one as **reuse**, **extend** or **new**.
Show the table to the user and **wait for confirmation**.

## 3. Spec

Run `component-spec` for each **extend** or **new** component.
Present all specs together and **wait for approval**.

## 4. Build

Run `ui-build` for each component, leaf components first. Then compose the
screen from them.

## 5. Review loop

Run `design-review` on the feature.
- `CHANGES REQUESTED` → `ui-build` with the review file → `design-review` again.
- Maximum **3 iterations**. If still not approved, stop and show the user the
  remaining findings; a human decides.

## 6. Close

Summarize: components reused / extended / created, decisions taken (suggest an
ADR if any decision affects other teams), open findings, and anything that
needs a human designer's call.
