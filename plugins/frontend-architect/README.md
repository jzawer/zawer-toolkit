# frontend-architect

La capa de **diseño, calidad visual y arquitectura front-end** para agentes de código
(Claude Code y GitHub Copilot): setup del proyecto, decisiones de arquitectura como ADRs,
librería de componentes, contratos de diseño, construcción y verificación de lo que ve el usuario.

Es independiente de plugins de proceso de ingeniería (specs, tickets, TDD, debugging):
no los necesita ni los sustituye. Cuando encuentra trabajo que les corresponde, `process-handoff`
prepara un brief y te dice qué comando ejecutar (con adaptador para las skills de Matt Pocock,
o pasos genéricos si no tienes ninguno).

## Empieza aquí

```
/setup-frontend-architect
```

## Skills

### Las lanzas tú

| Skill | Qué hace | Escribe |
|---|---|---|
| `setup-frontend-architect` | Wizard: diagnóstico de la UI, herramientas y decisiones de arquitectura | `docs/agents/frontend.md`, ADRs, bloque en `CLAUDE.md`/`AGENTS.md` |

### Las lanza el modelo (o tú)

**Arquitectura**

| Skill | Qué hace | Escribe |
|---|---|---|
| `component-library-strategy` | Qué librería de componentes usar y cómo organizarla entre equipos | ADR, sección de librería en la config |
| `frontend-boundaries` | Convierte la estructura de carpetas y la topología en reglas de lint | config de dependency-cruiser / eslint, ADR |
| `rendering-strategy` | CSR, SSR, SSG, ISR o islands por grupo de rutas | ADR |

**Diseño**

| Skill | Qué hace | Escribe |
|---|---|---|
| `design-context` | Intención de diseño | `DESIGN.md` |
| `design-tokens` | Audita y define tokens (DTCG) | `design/tokens.json` |
| `component-spec` | Especifica un componente (librería o app) antes de construirlo | `design/components/<name>.md`, `design/inventory.md` |

**Construcción**

| Skill | Qué hace | Escribe |
|---|---|---|
| `ui-feature` | Orquestadora: una funcionalidad de UI de principio a fin | — |
| `ui-build` | Implementa según la spec, con stories | código + stories |

**Calidad**

| Skill | Qué hace | Escribe |
|---|---|---|
| `ui-drift-audit` | Duplicados, valores fuera de tokens y patrones que compiten; línea base para CI | `design/audits/*.md`, `design/audits/baseline.json` |
| `design-review` | Dos revisores en paralelo (visual y accesibilidad) | `design/reviews/<name>.md` |
| `visual-baseline` | Capturas de referencia de UI aprobada para detectar regresiones | snapshots |
| `performance-budget` | Presupuestos de tamaño y Core Web Vitals en CI | config de size-limit / Lighthouse CI |

**Puente con el proceso de ingeniería**

| Skill | Qué hace | Escribe |
|---|---|---|
| `process-handoff` | Traspasa lo que no es de este plugin (componente compartido que falta, migración, refactor de límites, bug de comportamiento, decisión disputada, lógica) y dice qué comando ejecutar | `design/handoffs/*.md` |

## Agentes

| Agente | Rol | Herramientas | Modelo |
|---|---|---|---|
| `component-scout` | Busca componentes reutilizables (primero en la librería) y construye el inventario | solo lectura | haiku |
| `ui-drift-scanner` | Mide un tipo de deriva de UI (valores, componentes o patrones) | lectura + Bash | inherit |
| `design-reviewer` | Revisión visual, de spec, tokens, reutilización y límites | lectura + Bash | inherit |
| `a11y-auditor` | Auditoría de accesibilidad (axe, teclado, semántica) | lectura + Bash | inherit |

En Claude Code se usan como agentes con nombre. En otros agentes, las skills lanzan un
subagente genérico que sigue el mismo fichero `agents/<nombre>.md`.

## Contratos

| Fichero | Lo escribe | Lo leen |
|---|---|---|
| `docs/agents/frontend.md` | `setup-frontend-architect` (y las skills de arquitectura actualizan su sección) | todas |
| `docs/adr/*.md` | setup, `component-library-strategy`, `frontend-boundaries`, `rendering-strategy` | personas y agentes |
| `DESIGN.md` | `design-context` | todas las de diseño y calidad |
| `design/tokens.json` | `design-tokens` | `component-spec`, `ui-build`, revisores, `ui-drift-audit` |
| `design/inventory.md` | `component-spec`, `ui-drift-audit` | scout, `ui-build`, `ui-feature`, `visual-baseline` |
| `design/components/<name>.md` | `component-spec` | `ui-build`, revisores |
| `design/reviews/<name>.md` | `design-review` | `ui-build`, `ui-feature` |
| `design/audits/*` | `ui-drift-audit` | `component-library-strategy`, CI (ratchet) |
| `design/handoffs/*` | `process-handoff` | el plugin de proceso (p. ej. `/to-tickets <fichero>`), personas |

## Flujo

```
/setup-frontend-architect          (una vez por repo)
 ├─ ui-drift-audit quick ────► diagnóstico: duplicados, valores sueltos, patrones
 ├─ herramientas ────────────► stack, estilos, workbench, comandos, calidad
 ├─ arquitectura ────────────► topología · carpetas · librería · datos  → ADRs
 └─ seguimiento (opcional) ──► frontend-boundaries · rendering-strategy
                               performance-budget · ui-drift-audit (completo)

ui-feature
 ├─ design-context / design-tokens (si faltan)
 ├─ component-scout ─────────► librería → app: reutilizar / extender / nuevo   ◄── confirmación
 ├─ component-spec ──────────► spec con nivel (librería o app)                  ◄── aprobación
 ├─ ui-build ────────────────► código + stories, respetando límites
 └─ design-review (design-reviewer ∥ a11y-auditor)
      ├─ CHANGES REQUESTED → ui-build (máx. 3)
      └─ APPROVED → visual-baseline
```

### Traspasos al proceso de ingeniería

| Situación | Lo detecta | Con las skills de Matt |
|---|---|---|
| Falta un componente común en la librería | `component-spec` | `/to-spec` → `/to-tickets` → `/implement` |
| Consolidar componentes duplicados | `ui-drift-audit` | `/to-tickets design/handoffs/<fichero>.md` (o `/wayfinder`) |
| Arreglar violaciones de límites | `frontend-boundaries` | `/to-tickets design/handoffs/<fichero>.md` |
| Bug de comportamiento | `design-review` | `diagnosing-bugs` |
| Decisión de arquitectura disputada | `component-library-strategy`, setup | `/grill-with-docs` |
| Lógica no visual | `ui-build` | `tdd` |
