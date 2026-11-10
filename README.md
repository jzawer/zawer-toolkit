# dev-toolkit

Marketplace personal de plugins para agentes de código (Claude Code y GitHub Copilot),
orientado a trabajo de arquitectura.

| Plugin | Descripción |
|---|---|
| [`frontend-architect`](plugins/frontend-architect/README.md) | Flujo diseño → código: setup, contexto, tokens, specs, build y revisión multi-agente |

## 1. Instalar

Sustituye `<tu-usuario>` por tu usuario de GitHub.

<details>
<summary><strong>Claude Code</strong> (terminal, escritorio, VS Code, JetBrains)</summary>

```bash
claude plugin install frontend-architect --marketplace <tu-usuario>/dev-toolkit
```

Para recibir actualizaciones automáticas: `/plugin` → **Marketplaces** → `dev-toolkit` →
**Enable auto-update**. O a mano: `claude plugin update frontend-architect@dev-toolkit`.

</details>

<details>
<summary><strong>GitHub Copilot</strong> (CLI y VS Code)</summary>

```bash
copilot plugin marketplace add <tu-usuario>/dev-toolkit
copilot plugin install frontend-architect@dev-toolkit
```

En VS Code: **Chat: Install Plugin From Source** → `https://github.com/<tu-usuario>/dev-toolkit`.
El soporte de plugins en VS Code está en Preview (`chat.plugins.enabled`).

Los agentes con nombre (`component-scout`, `design-reviewer`, `a11y-auditor`) son de
Claude Code. En Copilot, las skills usan un subagente genérico con las mismas
instrucciones, así que el flujo funciona igual.

</details>

<details>
<summary><strong>Sesiones en la nube de Claude, o cualquier agente sin plugins</strong></summary>

Copia las skills y agentes dentro del proyecto y haz commit:

```bash
./scripts/install-into-project.sh /ruta/al/proyecto claude    # .claude/
./scripts/install-into-project.sh /ruta/al/proyecto copilot   # .github/
./scripts/install-into-project.sh /ruta/al/proyecto both
```

Vuelve a ejecutarlo para actualizar.

</details>

## 2. Configurar cada proyecto

Una vez por repo:

```
/setup-frontend-architect
```

Es un wizard: detecta el stack (o te ayuda a elegirlo en un proyecto nuevo, con ADR),
pregunta por estilos, componentes, workbench, comandos y nivel de calidad, y escribe
`docs/agents/frontend.md` más un bloque en `CLAUDE.md` / `AGENTS.md`.
Todas las demás skills leen esa configuración.

## Desarrollar

Probar sin instalar, desde un proyecto de ejemplo:

```bash
claude --plugin-dir /ruta/a/dev-toolkit/plugins/frontend-architect
```

Validar antes de subir:

```bash
./scripts/validate.sh
```

Para añadir skills, agentes o plugins, abre Claude Code en este repo y pídelo
("añade una skill de performance budget"). La skill de proyecto `new-component`
sigue las convenciones de [AGENTS.md](AGENTS.md).
