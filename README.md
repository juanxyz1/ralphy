# ralphy

CLI que ejecuta [Claude Code](https://docs.anthropic.com/en/docs/claude-code) en loop con planificación interactiva y code review automático.

Describes lo que quieres, ralphy enriquece tu plan analizando el proyecto, lo ejecuta N veces, y pasa 2 rondas de review antes de commitear. Fire and forget.

## Por qué

Ejecutar Claude Code manualmente funciona, pero:

- Pierdes tiempo iterando prompt → revisar → corregir → repetir
- No hay review automático — los bugs pasan desapercibidos
- No hay planificación contextual — Claude no analiza tu proyecto antes de empezar

Ralphy automatiza todo esto en un solo comando.

## Flujo

```
$ ralphy

┌─ ¿Existe PLAN.md? ──────────────────────────┐
│                                              │
├─ SÍ ─────────────────────────────────────────┤
│  Muestra preview del plan                    │
│  ¿Ejecutar? (s/n)                            │
│    s → ejecuta                               │
│    n → abre modo planificación               │
│                                              │
├─ NO ─────────────────────────────────────────┤
│  Abre modo planificación                     │
│  → sesión interactiva con Claude             │
│  → arrastra imágenes, itera, conversa        │
│  → guarda PLAN.md enriquecido                │
│  ¿Ejecutar? (s/n)                            │
│                                              │
├─ Ejecución ──────────────────────────────────┤
│  1. Ejecuta PLAN.md × N (sin commit)         │
│  2. Review #1: buscar y corregir             │
│  3. Review #2: validación final + commit     │
│                                              │
└──────────────────────────────────────────────┘
```

## Modo planificación

Cuando no hay plan o quieres replanificar, ralphy abre una sesión interactiva de Claude con un prompt maestro que:

- Analiza tu proyecto (estructura, stack, historial, patrones)
- Enriquece tu pedido desde múltiples ángulos
- Anticipa bugs, edge cases y conflictos con código existente
- Propone mejoras que complementen lo pedido sin cambiarlo
- Genera un `PLAN.md` ejecutable paso a paso

Puedes arrastrar imágenes a la terminal (wireframes, capturas, diagramas) para dar contexto visual.

## Instalación

```bash
git clone git@github.com:juanxyz1/ralphy.git
cd ralphy
./install.sh
```

Esto crea un symlink en `~/.local/bin/ralphy`. Asegúrate de tener `~/.local/bin` en tu `PATH`.

**Requisitos:**
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- git
- bash

## Uso

```bash
cd tu-proyecto
ralphy          # planifica (si no hay plan) y ejecuta
ralphy 3        # 3 ejecuciones + 2 reviews
ralphy -f       # forzar con worktree sucio
ralphy -f 3     # combinar ambos
ralphy -h       # ayuda
```

## Qué ves mientras trabaja

```
═══════════════════════════════════════════════
  Fase 1/3: Ejecución (1/2)
═══════════════════════════════════════════════

[ralphy] Log en vivo: tail -f .ralphy/logs/2026-04-09_20-17-35/fase1_ejecucion_1.log
  ⠹ Claude trabajando... 12:34 │ 3 files changed, 87 insertions(+), 14 deletions(-)
```

El spinner muestra en tiempo real cuántos archivos ha tocado Claude y cuántas líneas ha cambiado. Para ver el detalle completo, abre otra terminal y haz `tail -f` del log.

## Resumen al terminar

```
═══════════════════════════════════════════════
  Completado
═══════════════════════════════════════════════

  Tiempo total:  23m 47s
  Ejecución:     18m 12s (2 rondas)
  Review #1:      3m 20s
  Review #2:      2m 15s

  Commit: a1b2c3d — Añadir sistema de notificaciones push
  Archivos: 5 modificados, 2 creados
  Cambios:  +234 -45 líneas

  Logs: .ralphy/logs/2026-04-09_20-17-35
```

## Estructura

```
tu-proyecto/
  .ralphy/
    PLAN.md        ← plan generado por modo planificación (o manual)
    logs/          ← logs de cada ejecución
```

Añade `.ralphy/` a tu `.gitignore`.

## Seguridad

Ralphy inyecta guardrails automáticos a cada ejecución de Claude:

- No push a remoto
- No eliminar bases de datos
- No rm -rf fuera del directorio de trabajo
- No commitear .env ni credenciales
- No instalar paquetes globalmente
- No modificar archivos fuera del proyecto
- No amend de commits ajenos

Estos guardrails se aplican durante la ejecución automática. En modo planificación, el usuario controla la sesión directamente.

## Variables de entorno

| Variable | Default | Descripción |
|----------|---------|-------------|
| `CLAUDE_TIMEOUT` | `0` (sin límite) | Timeout en segundos por ejecución de Claude |

## Desinstalar

```bash
cd ralphy
./uninstall.sh
```

## Contribuir

1. Fork del repositorio
2. Crea tu rama (`git checkout -b mi-mejora`)
3. Haz tus cambios y commitea
4. Abre un Pull Request

No se pueden crear ramas directamente en este repositorio. Toda contribución se hace via PR desde forks.

## Licencia

MIT
