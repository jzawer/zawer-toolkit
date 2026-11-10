# dev-toolkit

Marketplace personal de plugins para Claude Code, orientado a trabajo de arquitectura.

| Plugin | Descripción |
|---|---|
| [`frontend-architect`](plugins/frontend-architect/README.md) | Flujo diseño → código: contexto, tokens, specs, build y revisión multi-agente |

## Instalar en cualquier proyecto

Sube este repo a GitHub y, desde Claude Code:

```
/plugin marketplace add <tu-usuario>/dev-toolkit
/plugin install frontend-architect@dev-toolkit
```

Para recibir cambios después: `/plugin marketplace update dev-toolkit`.

## Desarrollar

Probar un plugin sin instalarlo, desde un proyecto de ejemplo:

```bash
claude --plugin-dir /ruta/a/dev-toolkit/plugins/frontend-architect
```

Validar todo antes de subir:

```bash
./scripts/validate.sh
```

### Añadir skills, agentes o plugins

Abre Claude Code dentro de este repo y pide, por ejemplo,
"añade una skill de performance budget al plugin frontend-architect".
La skill de proyecto `new-component` (`.claude/skills/`) sigue las convenciones,
actualiza el README y el CHANGELOG, sube la versión y valida.

### Convenciones

- **Skill** si son instrucciones que sigue la conversación principal;
  **agente** si el trabajo debe ser independiente (revisiones, auditorías),
  lee mucho o puede ir en paralelo.
- Las skills se comunican por **ficheros con formato conocido** (contratos), no por la conversación.
- Los agentes revisores son de solo lectura y devuelven un formato fijo que la skill que los llama fusiona.
- Versión: minor al añadir componentes, patch al corregir.
