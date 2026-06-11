# Attributions

agr-launchpad bundles a small set of vendored skills/agents and points at several external plugins,
MCP servers, and tools. Credit and licenses below.

## Vendored skills (in `.claude/skills/`)

| Skill | Origin | Notes |
| --- | --- | --- |
| `grill-me` | Adapted from [mattpocock/skills](https://github.com/mattpocock/skills) (MIT) | Relentless plan/design interview. |
| `coding-standards` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Universal code conventions, trimmed to a language-agnostic core. |
| `error-handling` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Defensive error-handling patterns. |
| `secure-coding` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Upstream name `security-review`; renamed to avoid clashing with Claude Code's built-in `/security-review`. |
| `api-design` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | REST API design conventions. |
| `backend-patterns` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Server-side architecture patterns. |
| `frontend-patterns` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Frontend engineering patterns. |
| `webapp-testing` | [anthropics/skills](https://github.com/anthropics/skills) | Playwright-driven UI verification; license in the skill's `LICENSE.txt`. |
| `code-tour` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Guided codebase walkthroughs. |
| `skill-stocktake` | [ECC](https://github.com/affaan-m/ECC) community skills (MIT) | Skill inventory/audit. |
| `html` | first-party | Single-file styled HTML artifacts. |

Pack skills: `dashboard-builder` (ECC, MIT — Grafana/SigNoz operator dashboards) lives in
`packs/ops/`, installed only via `make use-pack name=ops`.

## Vendored agents (in `.claude/agents/`)

`architect`, `code-architect`, `code-explorer` — adapted from ECC community agents and reworked to
be domain-agnostic (architect = system-level design/ADRs, code-architect = feature blueprints,
code-explorer = existing-code tracing).

## External plugins (installed via Claude Code, not bundled here)

- **superpowers**, **skill-creator**, **frontend-design**, **code-review** — `claude-plugins-official`
  marketplace (`anthropics/claude-plugins-official`).
- **context-mode** — by Mert Köseoğlu, marketplace `mksglu/context-mode`.
- **claude-mem** — by Alex Newman (thedotmack), marketplace `thedotmack/claude-mem`.
- **gsd** — "get sh*t done" planning toolkit, installed separately into `~/.claude`.

Each plugin is governed by its own upstream license.

For deeper security auditing beyond the bundled `secure-coding` skill and the built-in
`/security-review`, the [trailofbits/skills](https://github.com/trailofbits/skills) marketplace
(Trail of Bits) is a credible opt-in: `claude plugin marketplace add trailofbits/skills`.

## MCP servers (referenced in `.mcp.json`)

- **context7** — Upstash `@upstash/context7-mcp`.
- **github** — [GitHub's official hosted MCP server](https://github.com/github/github-mcp-server).
- **jupyter** — Datalayer [`jupyter-mcp-server`](https://github.com/datalayer/jupyter-mcp-server) (BSD-3-Clause).
- **chrome-devtools** — [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) (Apache-2.0), optional.

## Tools

- **vscode-markitdown** — [BioInfo/vscode-markitdown](https://github.com/BioInfo/vscode-markitdown),
  a VS Code wrapper around Microsoft's [markitdown](https://github.com/microsoft/markitdown).
- **CodeTour** — [microsoft/codetour](https://github.com/microsoft/codetour) VS Code extension
  (`vsls-contrib.codetour`); plays the `.tour` files the `code-tour` skill produces.

If any attribution here is incomplete or incorrect, please open an issue — it will be fixed promptly.
