# agr-launchpad

**A batteries-included starting point for building anything with [Claude Code](https://claude.com/claude-code).**

Clone it, open it, approve a few prompts — and you have a solid, versatile setup: the most useful
general-purpose skills, plugins, MCP servers, and agents, ready to go. It's the *starting place*.
When you start a specific kind of project (ML, an iOS app, a journal…), you add a **pack** on top.

> New here? Open **[`docs/onboarding.html`](docs/onboarding.html)** in your browser — it's a friendly,
> step-by-step guide written for non-developers.

## Quickstart

1. **Install prerequisites:** [Claude Code](https://claude.com/claude-code) and [Node.js](https://nodejs.org) (LTS).
2. **Get your copy:** click **[Use this template](https://github.com/agrotisnicolaos/agr-launchpad/generate)**
   on GitHub (recommended — creates a clean repo of your own), or download the
   [latest release](https://github.com/agrotisnicolaos/agr-launchpad/releases/latest). Then:
   ```bash
   git clone <your-repo-url> agr-launchpad
   cd agr-launchpad
   ```
   Open the folder in Claude Code (or VS Code with the Claude Code extension).
3. **Install the plugins.** Trust the folder and **approve** the install prompts, *or* run one command:
   ```bash
   make install-plugins
   ```
   (Plugins live in your global Claude setup, so they can't ship pre-installed in a repo — this repo
   just pre-configures them. Confirm with `/plugin` or `claude plugin list`.)
4. **Approve the MCP servers** when asked (context7, github, jupyter — plus chrome-devtools, which
   is optional: decline it if you don't want browser debugging). Check with `claude mcp list`.
5. **Add secrets (optional):** `cp .env.example .env`, paste a GitHub token, then export it in the
   shell that launches Claude Code (`set -a; source .env; set +a; claude` — Claude Code does not
   read `.env` by itself; direnv automates this). Run `make setup` for a guided walkthrough.
6. **Restart Claude Code.** You're ready — just start describing what you want to build.

## What you get out of the box

**Plugins** (auto-offered on folder-trust, or `make install-plugins`):
- **superpowers** — disciplined workflows: brainstorming, planning, TDD, debugging, verification.
- **skill-creator** — build your own skills.
- **frontend-design** — distinctive, production-grade UI (by Anthropic).
- **code-review** — `/code-review` for diff review, plus `/code-review ultra` cloud multi-agent review.
- **context-mode** — keeps big tool output out of the context window.
- **claude-mem** — persistent memory across sessions.

**MCP servers** (`.mcp.json`): **context7** (live docs), **github** (your repos/issues/PRs —
GitHub's official hosted server), **jupyter** (live notebooks — `make jupyter`), and
**chrome-devtools** (optional — lets Claude screenshot pages and read console/network output to
verify UI work).

**Bundled skills** (zero-install, in `.claude/skills/`):
- *Clarify & review:* `grill-me`, `skill-stocktake`
- *Code quality:* `coding-standards`, `error-handling`, `secure-coding`
- *Backend & frontend foundations:* `api-design`, `backend-patterns`, `frontend-patterns`
- *See your output:* `html` (single-file artifacts), `webapp-testing` (Playwright screenshots/logs,
  by Anthropic), `code-tour` (guided walkthroughs)

**Bundled agents:** `architect` (system-level design & ADRs), `code-architect` (feature blueprints),
`code-explorer` (existing-code tracing).

`CLAUDE.md` teaches Claude when to reach for each of these — the kit routes itself. Run
`make check` to verify the catalog, configs, and files stay in sync.

**Installed separately** (see onboarding): **gsd** planning toolkit, **markitdown** VS Code extension.

## Packs

The base stays lean. Add project-specific capability with packs:

```bash
make list-packs              # see what's available
make new-pack name=ml        # scaffold a new pack from the template
make use-pack name=ml        # install a pack into the active config
make unuse-pack name=ml      # remove it
```

A pack bundles skills, agents, MCP servers, plugins, or a rulebook fragment. Local packs live in
`packs/` (`_template` and `ops` ship populated). Published packs install from the **agr·hub** marketplace
— already pre-registered here — with one command:

```
/plugin install <pack>@agr-hub
```

Browse available packs and projects at **[agrotisnicolaos.github.io/agr-hub](https://agrotisnicolaos.github.io/agr-hub/)**.
See [`packs/README.md`](packs/README.md) for building your own.

## Conventions

`CLAUDE.md` holds four behavioral principles (Think Before Coding · Simplicity First · Surgical
Changes · Goal-Driven Execution) plus an **Assets** routing section that tells Claude when to use
each bundled skill, agent, plugin, and MCP server. Packs append to it; the principles stay put.

## Attribution

See [`ATTRIBUTIONS.md`](ATTRIBUTIONS.md). Licenses belong to their respective upstream authors.
