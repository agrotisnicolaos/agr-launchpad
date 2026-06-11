#!/usr/bin/env sh
# agr-launchpad — consistency check. Validates that manifests/assets.json matches reality:
# every cataloged skill/agent path exists, settings.json plugins match the catalog,
# .mcp.json servers match, and every shipped skill has frontmatter. Run via `make check`.
set -eu
ROOT="$(CDPATH= cd "$(dirname "$0")/.." && pwd)"

python3 - "$ROOT" <<'EOF'
import json, os, re, sys

root = sys.argv[1]
fail = []

def load(rel):
    with open(os.path.join(root, rel)) as f:
        return json.load(f)

assets = load("manifests/assets.json")
settings = load(".claude/settings.json")
mcp = load(".mcp.json")

# 1. Cataloged skill/agent paths exist
for kind in ("skills", "agents"):
    for item in assets["base"][kind]:
        if not os.path.isfile(os.path.join(root, item["path"])):
            fail.append(f"assets.json {kind}: missing file {item['path']}")

# 2. Catalog covers everything actually shipped (no unlisted skills/agents)
listed_skills = {s["id"] for s in assets["base"]["skills"]}
on_disk = {d for d in os.listdir(os.path.join(root, ".claude/skills"))
           if os.path.isfile(os.path.join(root, ".claude/skills", d, "SKILL.md"))}
for extra in sorted(on_disk - listed_skills):
    fail.append(f"skill on disk but not in assets.json: {extra}")
for ghost in sorted(listed_skills - on_disk):
    fail.append(f"skill in assets.json but not on disk: {ghost}")

listed_agents = {a["id"] for a in assets["base"]["agents"]}
agents_dir = os.path.join(root, ".claude/agents")
disk_agents = {f[:-3] for f in os.listdir(agents_dir) if f.endswith(".md")}
for d in sorted(listed_agents ^ disk_agents):
    fail.append(f"agent mismatch between assets.json and .claude/agents/: {d}")

# 3. Plugins: settings.json enabledPlugins == assets.json declarative list
declared = set(assets["base"]["plugins"]["declarative"])
enabled = {k for k, v in settings.get("enabledPlugins", {}).items() if v}
for d in sorted(declared ^ enabled):
    fail.append(f"plugin mismatch between assets.json and settings.json: {d}")

# 4. Marketplaces: settings.json extraKnownMarketplaces == assets.json marketplaces
mk_assets = set(assets["base"].get("marketplaces", []))
mk_settings = set(settings.get("extraKnownMarketplaces", {}))
for d in sorted(mk_assets ^ mk_settings):
    fail.append(f"marketplace mismatch between assets.json and settings.json: {d}")

# 5. MCP servers: .mcp.json keys == assets.json mcpServers ids
mcp_assets = {s["id"] for s in assets["base"]["mcpServers"]}
mcp_real = set(mcp.get("mcpServers", {}))
for d in sorted(mcp_assets ^ mcp_real):
    fail.append(f"MCP server mismatch between assets.json and .mcp.json: {d}")

# 6. Every shipped skill (base + packs) has YAML frontmatter with name + description
skill_files = []
for base, _, files in os.walk(os.path.join(root, ".claude/skills")):
    skill_files += [os.path.join(base, f) for f in files if f == "SKILL.md"]
for base, _, files in os.walk(os.path.join(root, "packs")):
    skill_files += [os.path.join(base, f) for f in files if f == "SKILL.md"]
for sf in skill_files:
    with open(sf) as f:
        head = f.read(2000)
    m = re.match(r"^---\n(.*?)\n---", head, re.S)
    if not m or "name:" not in m.group(1) or "description:" not in m.group(1):
        fail.append(f"SKILL.md missing name/description frontmatter: {os.path.relpath(sf, root)}")

# 7. Populated packs in assets.json exist and have pack.json
for pack in assets["packs"]["populated"]:
    if not os.path.isfile(os.path.join(root, "packs", pack, "pack.json")):
        fail.append(f"pack listed as populated but packs/{pack}/pack.json missing")

if fail:
    print("FAIL — %d inconsistencies:" % len(fail))
    for f in fail:
        print("  ✗", f)
    sys.exit(1)
print("OK — assets.json, settings.json, .mcp.json, skills, agents, and packs are consistent.")
EOF
