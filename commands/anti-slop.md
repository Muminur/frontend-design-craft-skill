---
description: Scan for and rewrite the visual tells of AI-generated frontends
argument-hint: [path or "current file"]
---

# /anti-slop

Scan the target for AI-generated tells and rewrite them. This is the focused, surgical version of `/polish` for the taste lens specifically.

## Target

$ARGUMENTS

## The scan

Run through this checklist and report each hit with file:line:

### Gradients & color
- [ ] Purple → blue, pink → orange, teal → blue gradient on hero
- [ ] Gradient text
- [ ] `#000` pure black on `#FFF` pure white
- [ ] Default Tailwind `blue-*` / `purple-*` as primary brand
- [ ] More than one gradient moment per page

### Layout
- [ ] Centered hero: stacked headline + subhead + 2 CTAs + image below
- [ ] Three equal columns, icon-title-blurb feature pattern
- [ ] Equal-width logo cloud with generic startup names
- [ ] 3-tier pricing with middle tier highlighted "Most popular"
- [ ] Bento grid where every cell is the same radius and shadow
- [ ] FAQ accordion bolted to the bottom of every page

### Typography
- [ ] `Inter` loaded without justification
- [ ] All sections centered without a structural reason
- [ ] Heading and body using the same line-height
- [ ] No tracking adjustment on display sizes
- [ ] Default sentence case everywhere, no rhythm of cases

### Visual effects
- [ ] Glassmorphism / `backdrop-filter: blur` cards
- [ ] Neon glows on buttons or text
- [ ] Soft drop shadows on most elements
- [ ] Default shadcn/ui theme unmodified
- [ ] Heroicons / Lucide used unchanged

### Content
- [ ] `Lorem ipsum`
- [ ] `John Doe`, `Jane Smith`, `Acme`, `Example Co`
- [ ] Fake stats: "99.9% uptime", "10x faster", "Trusted by 10,000+ teams" without source
- [ ] Generic testimonials with first name + "CEO"
- [ ] Unsplash hero photos (laptops, sunsets, cities, hands on keyboards)
- [ ] Stock illustrations from unDraw / Storyset mashed together

## The rewrite

For each hit, propose a specific replacement. Do not just say "remove" — say what it becomes.

Examples (these are patterns, not commands):
- Centered hero → asymmetric 7/5 split with headline left, real product visual right
- `Inter` → archetype-appropriate sans (Geist, General Sans, Cabinet Grotesk, IBM Plex)
- Purple-blue gradient → solid brand color in OKLCH, used sparingly
- `Lorem ipsum` → write actual copy that fits the product
- `John Doe` → ask user for real names, or use varied realistic placeholders
- Three-column feature grid → rearrange as a single hero feature + supporting list, or 2x2 asymmetric

## Output

```
## Anti-slop scan

**Hits found:** [count]

### Critical (instantly recognizable as AI)
- file:line — [pattern] → [proposed replacement]

### High (common AI tell)
- ...

### Medium (would benefit from change)
- ...

**Auto-applied:** [list of changes made directly]
**Needs decision from user:** [list of changes requiring choice]
```

For anything requiring a real content decision (names, copy, product details), do not invent — ask the user.
