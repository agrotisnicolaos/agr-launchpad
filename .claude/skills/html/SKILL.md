---
name: html
description: Use to produce a standalone single-file HTML artifact — dashboards, data visualizations, embeddable charts, printable reports — that opens by double-click with no build step. Owns artifact packaging and data-wiring; defers visual/design-token decisions to frontend-design.
metadata:
  origin: first-party
  domain: viz
---

# html

Author self-contained HTML artifacts. This skill owns **packaging + data-wiring**; it composes
rather than duplicates:
- **`frontend-design`** (plugin) owns visual taste / design tokens — the source of aesthetics.
- **`webapp-testing`** owns looking at rendered output — use it to screenshot and verify the
  artifact actually renders before claiming done.
- Live observability dashboards (Grafana/SigNoz) belong to `dashboard-builder` in the **ops pack**
  (`make use-pack name=ops`); use this skill for standalone, no-server artifacts.

## Output contract
- **Single file:** inline CSS + JS, CDN-pinned libraries (chart.js / d3 / plotly — pin exact
  versions), no build step, opens by double-click, works offline.
- **Quality bar:** responsive; accessible (semantic tags, ARIA, sufficient contrast); graceful
  empty/error states; no external state stores.
- **First-class use cases:** data dashboards and visualizations; clean print/PDF; embeddable charts.

## Method
1. Pull aesthetic direction from `frontend-design` **before** building.
2. Wire the data: inline it, or load a sibling `data.json`. Gather any data via `ctx_execute`
   (context-mode plugin) or plain shell if the plugin is absent.
3. Build one file; verify it renders offline and is responsive; check the empty-data path.
4. Verify visually: render it (open in browser or use `webapp-testing` to screenshot) and look at
   it before claiming done.
