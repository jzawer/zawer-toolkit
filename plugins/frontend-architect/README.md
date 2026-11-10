# frontend-architect

Flujo de diseño → código para front-end: setup del proyecto, contexto de diseño,
tokens, specs de componentes, construcción y revisión con varios agentes en paralelo.
Funciona en Claude Code y GitHub Copilot.

## Empieza aquí

```
/setup-frontend-architect
```

## Componentes

### Skills

| Skill | Invoca | Qué hace | Escribe |
|---|---|---|---|
| `setup-frontend-architect` | solo tú | Wizard: stack, estilos, componentes, workbench, comandos, calidad | `docs/agents/frontend.md`, bloque en `CLAUDE.md`/`AGENTS.md`, ADR de stack |
| `ui-feature` | tú o el modelo | Orquestadora: una funcionalidad de UI de principio a fin | — |
| `design-context` | tú o el modelo | Intención de diseño | `DESIGN.md` |
| `design-tokens` | tú o el modelo | Audita y define tokens (DTCG) | `design/tokens.json` |
| `component-spec` | tú o el modelo | Especifica un componente antes de construirlo | `design/components/<name>.md`, `design/inventory.md` |
| `ui-build` | tú o el modelo | Implementa según la spec, con stories | código + stories |
| `design-review` | tú o el modelo | Lanza los dos revisores en paralelo y fusiona | `design/reviews/<name>.md` |

### Agentes

| Agente | Rol | Herramientas | Modelo |
|---|---|---|---|
| `component-scout` | Busca componentes reutilizables y construye el inventario | solo lectura | haiku |
| `design-reviewer` | Revisión visual, de spec y de tokens con capturas | lectura + Bash | inherit |
| `a11y-auditor` | Auditoría de accesibilidad (axe, teclado, semántica) | lectura + Bash | inherit |

En Claude Code se usan como agentes con nombre. En otros agentes, las skills lanzan un
subagente genérico que sigue el mismo fichero `agents/<nombre>.md`.

## Contratos

| Fichero | Lo escribe | Lo leen |
|---|---|---|
| `docs/agents/frontend.md` | `setup-frontend-architect` | todas |
| `DESIGN.md` | `design-context` | todas |
| `design/tokens.json` | `design-tokens` | `component-spec`, `ui-build`, revisores |
| `design/inventory.md` | `component-spec` (vía scout) | `component-spec`, `ui-build`, `ui-feature` |
| `design/components/<name>.md` | `component-spec` | `ui-build`, revisores |
| `design/reviews/<name>.md` | `design-review` | `ui-build`, `ui-feature` |

## Flujo

```
/setup-frontend-architect ───► docs/agents/frontend.md   (una vez por repo)

ui-feature
 ├─ design-context ──────────► DESIGN.md
 ├─ design-tokens ───────────► design/tokens.json
 ├─ component-scout ─────────► reutilizar / extender / nuevo   ◄── confirmación humana
 ├─ component-spec ──────────► design/components/*.md           ◄── aprobación humana
 ├─ ui-build ────────────────► código + stories
 └─ design-review
      ├─ design-reviewer ┐ en paralelo
      └─ a11y-auditor   ┘
           └──────────────► design/reviews/*.md ── CHANGES REQUESTED → ui-build (máx. 3)
```
