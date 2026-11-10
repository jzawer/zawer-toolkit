# Adapter: Matt Pocock's skills

Used when the `mattpocock-skills` plugin is installed. Commands may appear namespaced
(`/mattpocock-skills:to-spec`) or bare (`/to-spec`); give the user the form that appears in
their available skills.

Most of these skills read the issue tracker configured by `/setup-matt-pocock-skills`
(`docs/agents/issue-tracker.md`). If that file is missing, tell the user to run
`/setup-matt-pocock-skills` first.

| Situation | Recommended | Alternative | Notes |
|---|---|---|---|
| `missing-shared-component` | `/to-spec` (in this same conversation, after the brief is shown), then `/to-tickets`, then `/implement` | `/to-tickets design/handoffs/<file>.md` for a small, clear component | `to-spec` synthesizes from the conversation, so show the brief first. Tell the user that the UI part should go through `ui-build` and `design-review` once tickets exist. |
| `library-migration` | `/to-tickets design/handoffs/<file>.md` | `/wayfinder` when the migration is large or the canonical choices are still undecided | One ticket per duplicate group is a good slice: switch consumers to the canonical component, then delete the duplicate. |
| `boundary-refactor` | `/to-tickets design/handoffs/<file>.md` | `/improve-codebase-architecture` when violations point at a module that should be redesigned, not just moved | |
| `behavior-bug` | Ask to diagnose it with the `diagnosing-bugs` skill, passing the brief | `/diagnosing-bugs` typed by the user | `diagnosing-bugs` is model-invoked: you may call the Skill tool with it if the user agrees. |
| `contested-decision` | `/grill-with-docs` with the ADR and brief in the conversation | — | Records the outcome as ADR and glossary updates. Update `docs/agents/frontend.md` afterwards if the decision changes. |
| `logic-implementation` | The `tdd` skill for the logic, then return to `ui-build` for the UI | — | `tdd` is model-invoked: you may call the Skill tool with it if the user agrees. |

Never call a user-invoked skill (`to-spec`, `to-tickets`, `implement`, `wayfinder`,
`grill-with-docs`, `improve-codebase-architecture`) yourself: print the command for the user.
