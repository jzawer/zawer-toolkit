---
name: visual-baseline
description: Set up and maintain visual regression baselines - reference screenshots of approved components and pages across viewports and themes - so later changes that alter the UI are caught in CI. Use after a design review approves a component, when setting up visual regression testing, or when the user asks to detect unintended visual changes.
---

# Visual baseline

`design-review` judges whether UI is right once. A baseline makes sure it stays that way.

## Before you start

Read `docs/agents/frontend.md`: workbench and URL, viewports, themes, E2E command,
visual baseline tool if any. If missing, tell the user to run `/setup-frontend-architect`.

## 1. Choose the tool (first time only)

- **Playwright screenshot comparison** (`toHaveScreenshot`) over the workbench stories:
  no external service, snapshots live in the repo. Default choice.
- **Storybook test runner** with image snapshots, if the team already runs it.
- A hosted visual review service, if the team wants review UI and has one already.
Ask before adding dependencies. Record tool and snapshots path under **Visual baseline**
in `docs/agents/frontend.md`.

## 2. Make screenshots deterministic

Disable animations and transitions, wait for fonts, fix dates and random data, mock
network calls in stories, and use the same browser in CI and locally (a container if
needed). Flaky baselines get ignored, so fix flakiness before adding more snapshots.

## 3. Add baselines for approved UI

Only for components or pages marked `approved` in `design/inventory.md` (or that the
user explicitly approves): one snapshot per story × configured viewport × theme. Never
create a baseline from UI that hasn't passed `design-review`.

## 4. On a visual diff

When the check fails, decide with the user:
- **Unintended** change → it's a bug: fix the code, keep the baseline.
- **Intended** change → run `design-review` on the changed component first, then update
  the baseline in the same change, so the PR shows both code and new screenshots.

## 5. Report

Snapshots added or updated, components still without baseline, and flakiness found.
