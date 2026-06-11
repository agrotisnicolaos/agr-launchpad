# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

## Assets — when to reach for what

This kit's power is its assets. Skill/agent descriptions carry the full triggers; this section only
resolves the ambiguities between them. **Reach for the matching asset instead of working bare.**

### Clarify intent (before building)
- **superpowers:brainstorming** — Claude-initiated requirements exploration before any creative work.
- **grill-me** (bundled, canonical over the context-mode plugin's copy) — user-initiated: the user
  has a plan and wants to be interrogated about it branch-by-branch.

### Explore, then design
- **code-explorer** agent — dispatch to trace how an existing feature works (keeps exploration
  tokens out of the main context). For in-thread structural search, claude-mem's smart-explore.
- **architect** agent — system-level: greenfield design, stack selection, scalability, ADRs.
- **code-architect** agent — feature-level: implementation blueprint inside an existing codebase.

### While writing code
- **coding-standards** — baseline naming/readability/immutability conventions, any language.
- **error-handling** — any code touching errors, retries, or API failure paths.
- **secure-coding** — proactively when writing auth, user input handling, secrets, API endpoints,
  or payment/sensitive features. Before merging, run the built-in `/security-review` on the diff.
- **api-design** — designing or reviewing any HTTP/REST API contract.
- **backend-patterns** — server-side structure: services, data access, caching, queues.
- **frontend-patterns** — frontend logic: components, state, data fetching, performance.
- Process discipline (TDD, debugging, verification, planning) belongs to **superpowers**; multi-phase
  project planning belongs to **gsd**.

### Output & visual verification
- **frontend-design** plugin — visual taste for any UI work.
- **html** — standalone single-file artifacts: reports, charts, offline dashboards.
- **webapp-testing** — run a local web app, screenshot it, read console logs. **Never claim UI work
  is done without rendering and looking at it** — this skill (or the chrome-devtools MCP, if
  approved) is how.
- **code-tour** — persona-targeted `.tour` walkthroughs (played via the CodeTour VS Code extension).
- **jupyter** MCP — iterative data work and plots in a live kernel (`make jupyter` first).

### External knowledge & repo operations
- **context7** MCP — ALWAYS use for library/framework/API questions instead of answering from
  training memory; docs change faster than models.
- **github** MCP — issues, PRs, repos (needs `GITHUB_PAT` exported in the launch shell).

### Kit maintenance
- **skill-creator** plugin — author new skills (follow `packs/_template`'s frontmatter bar:
  descriptions must say precisely WHEN to trigger).
- **skill-stocktake** — audit the skill inventory after adding/removing packs or skills.

<!-- AGR-LAUNCHPAD:PACKS:START -->
<!-- Installed packs append their rulebook fragments below this line. Managed by scripts/use-pack.sh — do not edit by hand. -->
<!-- AGR-LAUNCHPAD:PACKS:END -->
