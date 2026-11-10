# frontend-architect

Flujo de diseño → código para front-end: contexto de diseño, tokens, specs de
componentes, construcción y revisión con varios agentes en paralelo.

## Componentes

### Skills (se invocan como `/frontend-architect:<nombre>`)

| Skill | Qué hace | Escribe |
|---|---|---|
| `ui-feature` | Orquestadora: lleva una funcionalidad de UI de principio a fin | — |
| `design-context` | Define la intención de diseño | `DESIGN.md` |
| `design-tokens` | Audita y define tokens (DTCG) | `design/tokens.json` |
| `component-spec` | Especifica un componente antes de construirlo | `design/components/<name>.md`, `design/inventory.md` |
| `ui-build` | Implementa según la spec, con stories | código + stories |
| `design-review` | Lanza los dos revisores en paralelo y fusiona resultados | `design/reviews/<name>.md` |

### Agentes (contexto propio, herramientas restringidas)

| Agente | Rol | Herramientas | Modelo |
|---|---|---|---|
| `component-scout` | Busca componentes reutilizables y construye el inventario | solo lectura | haiku |
| `design-reviewer` | Revisión visual, de spec y de tokens con capturas | lectura + Bash | inherit |
| `a11y-auditor` | Auditoría de accesibilidad (axe, teclado, semántica) | lectura + Bash | inherit |

## Flujo

```
ui-feature
 ├─ design-context ──────────► DESIGN.md
 ├─ design-tokens ───────────► design/tokens.json
 ├─ component-scout (agente) ► reutilizar / extender / nuevo   ◄── confirmación humana
 ├─ component-spec ──────────► design/components/*.md           ◄── aprobación humana
 ├─ ui-build ────────────────► código + stories
 └─ design-review
      ├─ design-reviewer (agente) ┐ en paralelo
      └─ a11y-auditor   (agente) ┘
           └──────────────► design/reviews/*.md ── CHANGES REQUESTED → ui-build (máx. 3)
```

## Requisitos en el proyecto

- Storybook (recomendado) o una ruta de demo para revisar componentes.
- Playwright y `@axe-core/playwright` para las revisiones.
