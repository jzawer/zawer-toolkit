# Adapter: no process plugin

Used when no engineering-process plugin is installed. Give the user plain next steps.

| Situation | Next step |
|---|---|
| `missing-shared-component` | Create an issue in the team's tracker from the brief (title + Problem + Acceptance criteria), owned by the shared library's maintainers. When it is picked up, build it with `component-spec` → `ui-build` → `design-review`. |
| `library-migration` | Create one issue per duplicate group from the brief: switch consumers to the canonical component, then delete the duplicate. |
| `boundary-refactor` | Create issues per violation group from the brief; fix the most-imported violations first. |
| `behavior-bug` | Create a bug issue with the reproduction steps and evidence from the review. Reproduce it with a failing test before fixing. |
| `contested-decision` | Schedule a short design discussion with the people affected; bring the ADR with options and trade-offs, and record the outcome in the ADR. |
| `logic-implementation` | Implement the logic test-first (failing test, minimal code, refactor), then return to `ui-build` for the UI. |

If the team uses a tracker CLI the agent can reach (for example `gh`), offer to create the
issue from the brief, and only do it on an explicit yes.
