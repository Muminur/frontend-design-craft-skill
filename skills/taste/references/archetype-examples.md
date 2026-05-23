# Archetype Examples — Site References

Each archetype is a coherent set of decisions about typography, color, density, and motion. Picking one and committing to it is more important than picking the "right" one.

## 1. Editorial / Restrained

Calm, content-forward, opinionated about hierarchy. Reads as serious without being severe.

**Reference sites in this lineage:** Linear, Vercel, Notion, Stripe Docs, Reflect, Sentry's marketing.

**Recipe:**
- **Type:** One high-quality sans (Geist, Söhne, IBM Plex Sans, Hanken Grotesk). Optional serif (Source Serif 4, Newsreader) for emphasis or quotes.
- **Type sizes:** Moderate. Headlines 32–56px; not 100px.
- **Palette:** Tinted near-white background, tinted near-black text, one restrained brand color used sparingly.
- **Density:** Medium-high. Lots of content per screen, generous internal whitespace.
- **Motion:** Minimal. State changes only. No scroll-triggered moments.
- **Layout:** Predominantly grid-aligned, occasional intentional asymmetry.
- **Visuals:** Real product screenshots, no stock photography, illustrations are technical/architectural.

**When to use:** Developer tools, B2B SaaS for technical audiences, documentation, productivity tools.

**Common failure mode:** Becomes boring when stripped too aggressively. Needs at least one moment of opinionated craft (a custom heading style, a single dramatic illustration) to avoid sterility.

## 2. Soft / Premium

Calm, expensive, generous. The aesthetic of luxury and lifestyle products.

**Reference sites in this lineage:** Arc Browser, Apple marketing, Pitch, premium DTC sites (Aesop, Glossier-era).

**Recipe:**
- **Type:** Generous sans (General Sans, Cabinet Grotesk) often paired with an emotional serif (Fraunces, Instrument Serif).
- **Type sizes:** Large. Display 72–128px. Generous body 18–20px.
- **Palette:** Cream / warm off-white background, deep tinted neutrals, optional muted brand color (terracotta, sage, oxblood — rarely blue).
- **Density:** Low. One idea per viewport. Lots of whitespace.
- **Motion:** Spring-based. Subtle, polished. One or two scroll-triggered moments per page.
- **Layout:** Asymmetric, off-grid moments, deliberately broken alignments for emotional weight.
- **Visuals:** High-quality photography (real, not stock), custom illustration, or no visual at all.

**When to use:** Consumer brands, lifestyle products, calm productivity apps, anything where the feeling of the page is part of the product.

**Common failure mode:** Slow to scan. If users need to compare features or pricing quickly, this archetype works against them.

## 3. Brutalist / Raw

Anti-corporate, information-dense, expressively ugly. The visual equivalent of a manifesto.

**Reference sites in this lineage:** Bloomberg Terminal, Are.na, modern brutalist portfolios, Read.cv, Tilde.club.

**Recipe:**
- **Type:** Helvetica, Times New Roman, or a single utilitarian face used at varied sizes. Optional: a single distinctive face (Departure Mono, GT Cinetype) as the entire identity.
- **Type sizes:** Wide range. Tiny captions (10–11px) next to massive display (120px+).
- **Palette:** Limited — often two or three colors total. High contrast. One saturated accent against B&W.
- **Density:** High. Sometimes deliberately crowded. Visible structure.
- **Motion:** None, or jarring on purpose. No spring physics, no easing curves softening edges.
- **Layout:** Grid-locked but with extreme variations in element sizes. Or deliberately broken alignments.
- **Visuals:** Raw photography, unprocessed screenshots, or no images at all.

**When to use:** Editorial, art, deliberately anti-corporate brands, internal tools that prize information density, indie products that want to signal "not enterprise SaaS."

**Common failure mode:** Hostile to general audiences. Use only when the audience self-selects.

## 4. Expressive / Display

Brand-led, motion-rich, the design *is* the product proposition.

**Reference sites in this lineage:** Awwwards winners, agency portfolios (Active Theory, Locomotive, Resn), music sites, fashion brands.

**Recipe:**
- **Type:** Display face used dramatically, often as the entire visual identity (Cabinet Grotesk, PP Editorial New, Boogy Brut, custom).
- **Type sizes:** Extreme range. Display sizes routinely 120–240px.
- **Palette:** Confident, often non-traditional (deep greens, oranges, dusty pink, sand, oxblood).
- **Density:** Variable. Generous around hero moments, denser in supporting sections.
- **Motion:** Substantial. Scroll-driven moments, custom transitions, occasionally WebGL.
- **Layout:** Highly asymmetric. The grid is broken intentionally. Elements overlap, type runs off the edge.
- **Visuals:** Custom illustration, custom photography, 3D, motion graphics.

**When to use:** Marketing for brands where design is the differentiator. Agency sites, fashion, music, creative tools.

**Common failure mode:** Performance disaster if not engineered carefully. Inaccessible by default — accessibility must be added back deliberately. Time-consuming to build.

## 5. Technical / Engineered

Precise, dense, fast. The aesthetic of "made by engineers, for engineers."

**Reference sites in this lineage:** Stripe homepage, Cloudflare, Datadog, Vercel (overlaps with Editorial), Railway, Modal.

**Recipe:**
- **Type:** Sans + mono pairing (Geist + Geist Mono, IBM Plex Sans + Plex Mono, Inter + JetBrains Mono).
- **Type sizes:** Moderate. Headlines 36–64px. Body 16px. Mono used in product visuals and code.
- **Palette:** Restrained. Typically a single saturated brand color against neutrals. Semantic colors for state.
- **Density:** Medium-high. Information-rich without feeling cluttered.
- **Motion:** Precise. Fast easing curves. Functional only — state, focus, feedback.
- **Layout:** Grid-aligned, predictable structure. Asymmetry only in service of clarity.
- **Visuals:** Code samples, terminal screenshots, architecture diagrams. No stock anything.

**When to use:** Developer tools, API products, infrastructure, observability, technical B2B.

**Common failure mode:** Can feel cold for end-user products. Works for developer tools precisely because the audience prefers cold to warm.

## Mixing archetypes

Mostly: don't. A single site picks one archetype and applies it everywhere.

Exceptions where a deliberate mix works:
- **Marketing site (one archetype) → product UI (another archetype).** Common: Expressive marketing → Technical product. Or Soft/Premium marketing → Editorial product. The mode boundary is clean.
- **A single page that shifts archetype as the user scrolls.** Risky, but can work when the shift signals a chapter break in the narrative.

Mixing within a single section, or randomly across the site, reads as confusion — not range.
