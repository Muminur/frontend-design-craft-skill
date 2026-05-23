---
name: craft
description: Distinctive, production-grade website and frontend design. Use whenever the user wants to build, redesign, review, polish, audit, or improve any UI — including landing pages, dashboards, marketing sites, components, forms, hero sections, settings panels, onboarding flows, or empty states. Covers visual hierarchy, typography, spacing, layout, color, motion, micro-interactions, accessibility, responsive behavior, and removing the generic "AI-generated" look. Triggers on phrases like "design", "redesign", "make it look better", "polish", "audit", "this looks AI-generated", "more premium", "more distinctive", "fix the layout", "fix spacing", "add animation", or any request involving the visual quality of a frontend.
---

# Craft — Website Design

A frontend can be technically correct and still look generic, flat, or unmistakably AI-generated. **Craft** is the layer that turns "it works" into "it looks intentional." It is organized around three lenses that must all be applied; none of them alone is sufficient.

## The three lenses

| Lens | What it owns | Sub-skill |
| --- | --- | --- |
| **Motion** | Animations, transitions, easing, choreography, micro-interactions | `motion` |
| **Polish** | Typography, spacing, layout, color, visual hierarchy, alignment | `polish` |
| **Taste** | Removing AI tells, content authenticity, distinctive aesthetics | `taste` |

When the user asks for design work, do not collapse these into one pass. Apply them in this order:

1. **Polish first.** A site with broken hierarchy and arbitrary spacing cannot be saved by animation or taste. Fix the bones.
2. **Taste second.** Once structure is sound, strip the AI-generated tells and make deliberate aesthetic decisions.
3. **Motion last.** Animation amplifies whatever is already there. Apply it to a polished, tasteful interface and it elevates; apply it to a generic one and it just makes the generic interface move.

## Two modes — pick one before starting

Ask which mode the user is in if it is not obvious from context. Brand sites and product UIs need opposite things, and applying brand rules to a dashboard (or product rules to a marketing page) is one of the largest sources of bad output.

**Brand mode** — marketing sites, landing pages, portfolios, editorial, launch pages
- Design is the product. Expressive type, larger hero moments, more whitespace, looser grid, more motion is acceptable.
- Bias toward distinctiveness over conventional patterns.
- Fluid typography is appropriate.
- Hero sections, custom illustrations, scroll-triggered moments are on the table.

**Product mode** — app UIs, dashboards, settings panels, internal tools, B2B SaaS
- Design serves the task. Tighter density, fixed type scales, restrained motion, predictable patterns.
- Bias toward clarity and learnability over expressiveness.
- Never use fluid type for app UI body text — it makes the interface feel unstable across breakpoints.
- Animation must be functional (state transitions, focus, feedback) — never decorative.

## The three dials

For any project, set these explicitly and tell the user what you chose. Do not leave them implicit.

```
VARIANCE: 1–10   How far from symmetric, conventional layouts to push.
                 1 = centered hero, equal columns, predictable grid.
                 10 = asymmetric, off-grid, broken alignments used intentionally.
                 Brand: 6–9. Product: 2–4.

MOTION: 1–10     How much animation and how cinematic.
                 1 = state changes only, no movement.
                 10 = scroll-triggered choreography, magnetic hovers, page transitions.
                 Brand: 5–8. Product: 2–4.

DENSITY: 1–10    How much information per viewport.
                 1 = gallery — one idea per screen, generous whitespace.
                 10 = cockpit — every pixel earns its place (e.g., trading dashboards).
                 Brand: 2–4. Product: 5–8.
```

Setting these wrong is the single most common failure mode. A landing page with `DENSITY: 8` will look like a wall of text. A dashboard with `VARIANCE: 9` will be unusable.

## When to use which sub-skill

- The user says **"this looks AI-generated" / "make it more distinctive" / "less generic"** → `taste` first, then `polish`.
- The user says **"fix spacing" / "the hierarchy is off" / "the typography looks bad"** → `polish`.
- The user says **"add animation" / "make it feel more alive" / "the transitions are choppy"** → `motion`.
- The user says **"audit my site" / "review this component"** → all three, run in the order above.
- The user is **starting from scratch** → all three, with `polish` providing the skeleton, `taste` providing the aesthetic direction, and `motion` providing the final layer.

## Hard rules that apply across all three lenses

These are non-negotiable regardless of mode or dial settings.

1. **No placeholder content.** If a real headline is not available, write one that fits the product. No "Lorem ipsum", no "Your headline here", no `John Doe` users, no "99.9% uptime" fake stats, no Unsplash hero photos of laptops on desks.
2. **No off-the-shelf shadcn/UI defaults.** If `shadcn/ui` is used, override the default theme, radius, and color tokens. The defaults are recognizable on sight.
3. **Real content shapes real layouts.** Design around the actual headline length, the actual product name, the actual data — not around lorem placeholders that will all be the same length.
4. **Accessibility is a hard floor, not a polish step.** WCAG AA contrast minimum, focus rings visible, semantic HTML, `prefers-reduced-motion` respected. Treat these as preconditions, not features.
5. **No `<form>` tags in React artifacts.** Use `onClick` / `onChange` handlers instead.
6. **No `localStorage` / `sessionStorage` in artifacts.** Use React state. (Artifacts run sandboxed.)

## The slash commands

The plugin ships with these commands. They map to common workflows:

| Command | Use when |
| --- | --- |
| `/audit` | First pass on an existing site or component. Surfaces issues; does not fix them. |
| `/polish` | Final pre-ship pass. Tighten alignment, spacing, micro-details. |
| `/critique` | UX review. Hierarchy, clarity, what to remove. |
| `/typeset` | Typography is the problem — fonts, sizes, weights, line-height, tracking. |
| `/arrange` | Layout is the problem — spacing, alignment, grid, vertical rhythm. |
| `/animate` | Add or fix motion. |
| `/colorize` | Introduce or rework color strategy. |
| `/distill` | Remove things. Strip the interface to what earns its place. |
| `/bolder` | Design is too safe / too quiet / too corporate-blue. |
| `/quieter` | Design is too loud / over-decorated / fighting for attention. |
| `/delight` | Add a memorable moment, sparingly. |
| `/anti-slop` | Scan specifically for AI-generated tells and rewrite them out. |
| `/extract` | Pull repeated patterns into reusable components and tokens. |

## What this plugin will not do

- Override an explicit, considered design choice from the user. If they say "I want a centered hero with three columns," do that — these rules are defaults, not laws.
- Apply brand-mode treatment to clearly product-mode work, or vice versa.
- Animate for its own sake. Motion without purpose is noise.
- Pick the visual direction silently. Always state which mode, archetype, and dial settings are being used so the user can correct them.

## See also

- `skills/motion/SKILL.md` — animation principles, easing, timing, choreography
- `skills/polish/SKILL.md` — typography, spacing, layout, color, hierarchy
- `skills/taste/SKILL.md` — anti-slop rules, style archetypes, content authenticity
