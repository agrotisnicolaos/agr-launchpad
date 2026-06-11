---
name: explain-agr
description: Use whenever the user types /explain-agr, asks "explain X to me", "what is X", "how does X work", "help me understand X", or "ELI5 X" — even if they sound technical, default to this skill unless they ask for an expert-level answer. Works in Claude chat and Claude Code.
origin: first-party
---

# explain-agr — beginner-first concept explainer

Explain things the way a great teacher does: start with why it matters, build up from
pieces the listener already understands, and never use a word that needs its own explanation.

**Assume zero prior knowledge and a non-technical reader.** This is the core constraint.
If a sentence would confuse a smart 15-year-old or your parent, rewrite it. Jargon is
allowed only after you've defined it in plain words — and prefer not introducing it at all.

**Depth beats brevity.** The job is not done when the explanation is short and tidy; it is
done when a beginner could re-explain the concept to someone else. When thoroughness and
word count conflict, thoroughness wins.

## Aim before you fire

Do NOT ask the user questions up front — start explaining immediately. Instead, infer:

- **What they likely already know** — from the conversation, the project, their past messages.
  Skip blocks they've demonstrated; don't re-explain their own tools to them.
- **Why they're asking** — and tailor the hook and examples to THEIR situation. An example
  drawn from the user's own project or session beats a generic one every time.
- Only ask first when the topic is genuinely too broad to aim at ("explain math") — offer
  the 2–3 most useful sub-topics, or pick the most likely one and say so.

## Hard formatting rules (apply to every section)

The output must be **scannable, not prose**. Walls of paragraphs are a failure mode
even when the words are simple.

- **No paragraph longer than 2 sentences — anywhere, including the opening hook.**
  If a third sentence is forming, break into bullets or start a new line. This is the
  most common failure mode; check for it explicitly before sending.
- **Bullets and sub-bullets** are the default for any decomposition or list of parts.
  Prose is reserved for 1–2-sentence connective tissue.
- **Arrows (`→`) for sequences and cause/effect**: `you type the name → computer checks
  its note → asks the phone book → gets the number → page loads`.
- **Show structure visually.** Whenever you describe something that HAS a shape —
  a hierarchy, a container, a pipeline, layers, a network — draw it as a small ASCII
  diagram in a code block instead of describing it in words:

  ```
  PLUGIN (one folder)
  ├── skills/      → recipe cards Claude reads on demand
  ├── agents/      → specialist coworkers for sub-tasks
  ├── hooks/       → automatic doorbells ("when X happens, do Y")
  └── mcp servers/ → phone lines to outside tools
  ```

- **Tables for comparisons** (A vs B, do vs don't, before vs after).
- **Bold the one keyword** in each bullet so the eye can skim the left edge and still
  get the outline.

## Markdown presentation rules

The explanation must also LOOK well-built when rendered. Apply these mechanically:

- **Real headings** — use `##` for each major section and `###` for sub-points.
  Never fake a heading with a bold line; headings give readers a navigable outline.
- **`---` divider** between major sections, so boundaries are visible while scrolling.
- **One blockquote takeaway** immediately after the hook:
  `> **In one sentence:** …` — the entire concept compressed to one line.
- **Blank lines** before and after every list, table, code block, and heading —
  missing blank lines break rendering in many viewers.
- **Short bullets** — one line each where possible, two max; push detail into
  sub-bullets rather than letting a bullet grow into a paragraph.
- **Max two levels of nesting.** If a third level appears, promote it to a diagram
  or its own section.
- **In Claude Code: the entire explanation must be in the FINAL message of the turn,
  with no tool calls after it.** Text written before a tool call may never be shown
  to the user. Never end the explanation with an AskUserQuestion call.

## Output structure

Always use this shape (adapt headings to the topic; keep the order):

### 1. The hook — why should you care?
Open with **at most two short sentences**, then switch to bullets — never a paragraph:
- 2–3 bullets, each a concrete real-life moment where this thing was at work
  ("Every time you … that's X doing its job") — drawn from the USER's world when possible
- close the section with the one-line blockquote takeaway (see presentation rules)

### 2. The building blocks
**Sections 2–4 ARE the explanation — give them the most room, roughly two-thirds of the
total word count.** Never compress them to make space for the later sections; trim
sections 5–7 first.

Decompose the concept into the smallest set of simple pieces (usually 3–6), one
bullet per block:
- **Block name** — one plain sentence on what it is
  - one parallel from everyday life (kitchen, post office, traffic, money, sports…)
  - **if the block is abstract, add a SECOND analogy from a different domain.** One
    analogy can mislead; two triangulate the idea. Concrete, physical blocks may keep one.
  - one tiny concrete example, OR the one-line reason this piece needs to exist

If the blocks form a structure (parts inside a whole, layers, a tree), add the ASCII
diagram here. Pick analogies that hold up — a slightly less catchy analogy that doesn't
mislead beats a vivid one that breaks down a paragraph later.

### 3. Putting it together
Two parts, both required:

1. The **arrow chain or diagram** showing the whole flow end to end.
2. A **numbered walkthrough of ONE concrete scenario** — reuse an example from the
   hook and narrate it step by step through the blocks, one short line per step.
   The reader should feel the "click" of recognizing the hook example, now with
   the machinery visible.

End the section with a short "**what this design buys**" pair of bullets — the 1–2
properties the whole arrangement exists to achieve (speed, safety, cost, scale…).

### 4. Where people get this wrong — REQUIRED
The highest-leverage teaching move: predict the reader's confusion before they hit it.

- **2–3 misconceptions** a beginner predictably forms about THIS topic, each as a pair:
  - **"You might think…"** — the wrong mental model, stated sympathetically
  - **"Actually…"** — the correction, in one or two plain sentences, tied back to a
    building block from section 2
- Pick real confusions (the ones forums and Stack Overflow questions reveal), not
  strawmen. If an analogy you used has a known breaking point, name it here.

### 5. Successful examples in the wild
Name 2–4 real, recognizable, successful instances of the thing — products, companies,
projects, or events the reader may have heard of — with one line each on why it counts
as a success. ("**Wikipedia** runs on this", "**Stripe's API** is the textbook example
of this done well".) Real names make the concept feel real; pick famous over obscure.

### 6. What this does for YOU
2–4 bullets answering "so what?" for the reader personally — time saved, money saved,
mistakes avoided, new things they could build or decide. Tie benefits to the reader's
likely situation (use what you know from the conversation). This is distinct from
step 1: step 1 is "why this exists in the world", this is "why it's worth YOUR while".

### 7. Best practices & common mistakes
A short two-column table or paired bullets:

| ✅ Do | ❌ Don't |
|------|---------|
| the 2–4 habits practitioners agree on | the 2–4 mistakes beginners actually make |

Keep each cell one line. Only include advice that is actionable for someone USING or
ADOPTING the thing. For purely descriptive topics (e.g. "explain gravity") drop this
section — section 4 already covers misconceptions.

### 8. References — clickable links, always
End with 2–4 credible sources for going deeper. **Every reference must be a markdown
link** — `[Cloudflare — What is DNS?](https://www.cloudflare.com/learning/dns/what-is-dns/)` —
never a bare name like "the Cloudflare DNS page" or a domain without a path.

- **With web access:** verify each URL actually resolves (search or fetch) before
  listing it. A broken link is worse than no link.
- **Without web access:** link only URLs you are highly confident are real and stable
  (official docs roots, major orgs). For anything else write `search for "…"` —
  never invent a URL.
- Prefer: official documentation → well-known textbook/university page → respected
  explainer (major publication or the technology's own site).

**Good-to-have (when web search is available):** quietly look for one YouTube explainer
with **more than 500K views from a credible channel** (an institution, a well-known
educator, the official channel — not view-farmed content). If found, add it as a link:
`Watch: [Title](url)`. If nothing credible clears the bar, skip it silently.

### 9. The go-deeper close — plain text, no tool calls
End the explanation with two things, as ordinary text:

1. **A named menu of 2–3 deeper branches** specific to this topic — concrete sub-topics
   by name ("how hooks differ from skills", "what a marketplace actually verifies"),
   never a generic "any questions?". Confused readers can't name what they didn't get;
   a menu does it for them.
2. **One line offering the HTML version**: a standalone visual page they can keep
   (built with the `html` skill if they ask). Don't build it unless they ask.

## Follow-ups: going deeper

When the user picks a branch (or asks anything after the explanation):

- **Stay in beginner mode** — depth increases, vocabulary doesn't. More machinery,
  same plain words.
- Go genuinely deeper: new building blocks, a new diagram if the structure changed,
  a new misconception if the deeper layer has one. Don't pad or re-summarize.
- Don't repeat the full structure — answer directly, keep the formatting rules,
  and close with a fresh (smaller) go-deeper menu if natural branches remain.

## The thoroughness pass

Before responding, reread your draft and ask: **"Would a beginner actually get this —
and could they re-explain it?"** Hunt for:

- any building block explained but not grounded in an analogy or example
- an abstract block with only one analogy (add the second)
- a step in the walkthrough that silently assumes knowledge from nowhere
- a misconception section that's generic enough to fit any topic (make it specific)
- any paragraph over 2 sentences (break it up)
- jargon that slipped in undefined
- references that aren't markdown links

**Never cut explanatory steps to save words.** The simplification pass may tighten
sentences and trim sections 5–7, but sections 2–4 lose depth only if something is
genuinely redundant. Length guide: ~800 words for simple topics, 1500–2500 for layered
ones (TLS, OAuth, kernels…) — earn every line, but spend the lines the topic needs.

## Calibration

- If the user signals they already know part of the topic, skip those blocks — don't
  re-explain what they've demonstrated.
- If asked a follow-up, see "Follow-ups: going deeper" above.

## Example skeleton

**Input:** `/explain-agr DNS`

**Output shape:**
> ## Why should you care?
> Type "google.com" and the page just appears — DNS did that.
> - **Every website visit** starts with a DNS lookup you never see
> - **"Site is down"** is often just DNS being down — knowing the difference helps
>
> > **In one sentence:** DNS is the internet's phone book — it turns names humans
> > remember into numbers computers need.
>
> ---
>
> ## The building blocks
> - **Addresses** — every computer has a number…
>   - like a phone number for a house
>   - google.com is really 142.250.80.46 underneath
> - **The phone book** — a service that turns names into numbers…
> - **Caching** — keeping recent lookups nearby…
>   - like a number scribbled on a sticky note
>   - or like keeping the milk at the front of the fridge — fetched once, reused cheap
>
> ```
> you → [sticky note?] → [phone book] → number → site
> ```
>
> ---
>
> ## Putting it together
> `type the name → check sticky note → if missing, ask phone book → get number → page loads`
>
> Walking through the hook example:
> 1. You type "google.com" and press enter
> 2. Your computer checks its sticky note (cache) — not there
> 3. It asks the phone book (a DNS server) …
>
> **What this design buys:** speed (sticky notes skip the lookup) and resilience
> (many phone books, not one).
>
> ---
>
> ## Where people get this wrong
> - **You might think** DNS stores the websites themselves.
>   **Actually** it only stores the address — the site lives elsewhere; DNS just points.
> - **You might think** there's one big phone book somewhere.
>   **Actually** it's thousands of cooperating ones — that's why it survives failures.
>
> ---
>
> ## In the wild / For you / Do–Don't table / References … (as specified above)
>
> ---
>
> **Want to go deeper?** Pick a branch:
> - how the phone book is split across thousands of servers (root → TLD → authoritative)
> - what happens when DNS lies (spoofing, and why DNSSEC exists)
> - why changing DNS takes "24–48 hours" (TTLs and caching)
>
> Or say the word and I'll turn this into a standalone visual HTML page you can keep.
