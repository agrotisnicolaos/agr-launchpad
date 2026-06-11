# Packs

The base starter is deliberately lean and universal — it sets you up to build *anything*. **Packs**
are how you add capability for a *specific kind* of project without bloating the base.

A pack bundles project-specific **skills**, **subagents**, **MCP servers**, and a **rulebook
fragment**. You install one when you start that kind of project; you remove it when you're done.

## Using a pack

```bash
make use-pack name=<pack>     # merge a pack into the active config
make unuse-pack name=<pack>   # remove it
make list-packs              # show available + installed packs
```

`use-pack` does four reversible things:
1. copies the pack's skills into `.claude/skills/`
2. copies the pack's agents into `.claude/agents/`
3. merges the pack's `mcp.partial.json` into `.mcp.json` (never overwriting existing servers)
4. appends the pack's `CLAUDE.pack.md` into the managed block in `CLAUDE.md`

## Building a pack

```bash
make new-pack name=<pack>     # scaffold packs/<pack> from _template
```

Then edit the generated files and `make use-pack name=<pack>`. See [`_template/`](_template/) for
the anatomy and conventions.

## Planned packs (examples)

These are the kinds of packs this system is built to hold — build them as you need them:

| Pack | What it would add |
| --- | --- |
| `ml` | data/ML skills, eval & regression-testing agents, notebook conventions |
| `ios` | Swift/SwiftUI patterns, concurrency, on-device model skills, build-resolver agents |
| `journal` | journaling/writing skills, daily-note templates, reflection prompts |
| `web` | framework-specific frontend depth beyond the base `frontend-patterns` skill, a11y agents |
| `backend` | framework-specific backend depth (Django/Rails/Spring…) beyond the base `backend-patterns` skill |

Two ship populated: [`_template/`](_template/) (the scaffold) and [`ops/`](ops/) (Grafana/SigNoz
dashboard building — platform-specific, so it lives here rather than in the base). That's
intentional: the base stays clean, and you grow the catalog deliberately.
