# Banned Patterns — Extended Catalogue of AI Tells

A pattern is banned by default when it appears in the median AI-generated frontend often enough that informed designers recognize it on sight. Each item below includes the pattern, why it reads as AI, and what to do instead.

## Gradients

### Purple → blue hero gradient
- **Why AI:** Trained on a decade of dashboard mockups using this exact gradient.
- **Instead:** Solid brand color in OKLCH, or a subtle off-white surface with a single accent.

### Pink → orange / coral gradient
- **Why AI:** Same era, different palette. Both signal "we asked an LLM for a hero."
- **Instead:** A confident single color, or a duotone treatment on a real photo.

### Teal → blue gradient
- **Why AI:** The "developer tool" variant of the above.
- **Instead:** A single saturated teal or blue, used sparingly.

### Gradient text
- **Why AI:** Almost no professional designer uses gradient text outside of one brand mark.
- **Instead:** Solid color. If emphasis is needed, use weight or size.

## Surfaces

### Glassmorphism (`backdrop-filter: blur`)
- **Why AI:** Peak adoption in 2021–2022; never disappeared from training data.
- **Instead:** Real elevation via shadow + background contrast, or a flat surface with a thoughtful border.

### Neumorphism (soft inset/outset shadows)
- **Why AI:** Briefly trendy in 2020; accessibility-hostile and dated.
- **Instead:** Flat surfaces or genuine shadow elevation.

### Neon glows on buttons/text
- **Why AI:** The "cyber" / "AI startup" aesthetic.
- **Instead:** Standard hover state with brand color shift.

### Soft drop shadows on every element
- **Why AI:** The default Tailwind shadow applied indiscriminately.
- **Instead:** Use shadow as a hierarchy tool. Most elements need none.

### Pure black backgrounds (`#000`) for "dark mode"
- **Why AI:** Lazy default. Real dark mode uses a tinted near-black.
- **Instead:** `oklch(15% 0.015 H)` where H is the brand hue, or similar.

## Typography

### `Inter` as the body font
- **Why AI:** Inter is genuinely great. It is also in approximately every AI-generated frontend on the internet.
- **Instead:** Geist, General Sans, IBM Plex Sans, Hanken Grotesk, Söhne, Cabinet Grotesk — match to archetype.

### Display sizes that ignore container width
- **Why AI:** Models do not check whether `text-7xl` fits the column.
- **Instead:** Calibrate display size to column width. A 96px headline in a 600px column needs to break across lines intentionally or be smaller.

### Centered paragraphs of body copy
- **Why AI:** Easy to write, hard to read.
- **Instead:** Left-align body. Center only short, declarative copy (1–2 lines).

### Same line-height for headings and body
- **Why AI:** Default browser line-height applied universally.
- **Instead:** Lower line-height on headings (1.1–1.2), higher on body (1.5+).

## Layout

### Centered-stack hero
The pattern: centered headline → centered subhead → two CTAs side-by-side → big image below.
- **Why AI:** It is the most common landing page shape in the training data.
- **Instead:** Asymmetric split (e.g., 7/5), or stacked-left with a clear hierarchy break.

### Three equal columns of icon-title-blurb
- **Why AI:** "Features section" stock template.
- **Instead:** One hero feature plus a list of supporting features; or asymmetric grid; or no features section at all (let the product do the talking).

### Logo cloud of generic startups
- **Why AI:** Filler that signals "social proof" without providing any.
- **Instead:** Either real customer logos, real testimonials, or remove.

### Three-tier pricing with "Most popular" highlighted middle tier
- **Why AI:** Industry standard, applied without thought.
- **Instead:** If pricing is genuinely three tiers, fine. Otherwise design around the actual offering — even a single-price card works.

### Bento grid where every cell looks identical
- **Why AI:** Bento works when cells have visual variation; the AI default has none.
- **Instead:** If using bento, ensure each cell has its own visual treatment (different content density, different visual emphasis, different content type).

### FAQ accordion bolted to the bottom of every page
- **Why AI:** Standard SaaS template.
- **Instead:** If FAQs are critical, design them properly. Otherwise consider replacing with a contact CTA or removing.

## Content

### `Lorem ipsum`
- **Why AI:** Signals "no one wrote this."
- **Instead:** Write real copy. If you cannot, ask the user for it.

### `John Doe`, `Jane Smith`, `Acme Inc`, `Example Co`
- **Why AI:** Default placeholder names.
- **Instead:** Varied realistic names that fit the product's audience. For a B2B SaaS, vary across `Maria Chen`, `David Okonkwo`, `Priya Sharma`, `Tom Anderson`. For consumer, mix more broadly.

### Fake stats: "99.9% uptime", "10x faster", "Trusted by 10,000+ teams"
- **Why AI:** Marketing-deck filler with no source.
- **Instead:** Real numbers with citation, or different framing (qualitative, story-based, omitted).

### First-name + "CEO" testimonials
- **Why AI:** Lazy attribution that no real customer would accept.
- **Instead:** Real attribution (full name, role, company) — or no testimonials.

### Stock photos of laptops, sunsets, hands on keyboards
- **Why AI:** The Unsplash hero photo problem.
- **Instead:** Real product screenshots, custom illustrations, abstract textures, or no image.

## Defaults left unmodified

### shadcn/ui default theme
- **Why AI:** Recognizable on sight by anyone who builds for the web.
- **Instead:** Override radius, color tokens, typography. Make it yours.

### Default Tailwind colors used directly (`bg-blue-500`)
- **Why AI:** No semantic intent.
- **Instead:** Define palette in OKLCH, alias as semantic tokens (`--color-primary`, `--color-surface`, etc.).

### Heroicons / Lucide used unchanged everywhere
- **Why AI:** Library default.
- **Instead:** Pick one icon library and use it consistently, but consider customizing stroke width, choosing a less-common library, or commissioning custom icons for brand work.

### Default form components with no styling
- **Why AI:** Browser defaults.
- **Instead:** Style inputs, labels, focus rings, and error states deliberately.

## Motion

### Every section fades up on scroll
- **Why AI:** Default scroll-animation template.
- **Instead:** Reserve scroll-triggered motion for 1–2 key moments per page.

### `transition: all` on everything
- **Why AI:** Easy default.
- **Instead:** Explicit property lists. `transition: transform 200ms ease-out, opacity 150ms linear;`

### Bouncing arrow / "scroll down" indicator
- **Why AI:** Decorative cue that real sites rarely need.
- **Instead:** Remove. If users need a scroll cue, the design is failing in other ways.

### Animated cursor / mouse trail
- **Why AI:** Demo-flashy, production-broken.
- **Instead:** Remove.

### Magnetic hover on every clickable element
- **Why AI:** Effect overuse.
- **Instead:** Reserve for the single primary CTA, if at all.

## Visual effects

### Custom cursors
- **Why AI:** Demo flair.
- **Instead:** Default cursors. They are good.

### Particles / floating dots backgrounds
- **Why AI:** "AI / tech" template asset.
- **Instead:** Remove. Or use a deliberate, custom-designed background.

### Glitch effects on text
- **Why AI:** Easy CSS trick that signals "look at me."
- **Instead:** Communicate through type weight, size, and color.

### Holographic / iridescent overlays
- **Why AI:** Aesthetic-of-the-month carryover.
- **Instead:** A solid color or a real photographic texture.
