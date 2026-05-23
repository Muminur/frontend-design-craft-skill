---
name: polish
description: Typography, spacing, layout, color, and visual hierarchy. Use when the user wants to fix or improve the foundational craft of an interface — font choices, type scale, line-height, tracking, spacing rhythm, grid, alignment, color palette, contrast, hierarchy, responsive breakpoints, or anything that determines whether the site feels considered or arbitrary. Triggers on "fix the spacing", "the typography is off", "hierarchy", "layout", "this looks unbalanced", "the colors clash", "make it look polished", "feels amateur".
---

# Polish

The fastest way to tell whether a frontend was thought about or generated is to look at the **type, the spacing, and the alignment**. Color and content can be middling, but if these three are right, the page reads as professional. If they are wrong, no amount of motion or visual flair can rescue it.

## Typography

### Font selection

The single most overused font in AI-generated frontends is **Inter**. It is not a bad face — it is just the visual signature of generic. Reach for it only when nothing else fits.

**Better defaults by context:**

| Context | Sans options | Serif / display options | Mono options |
| --- | --- | --- | --- |
| Product UI, dashboards | Geist, IBM Plex Sans, Söhne (commercial), Hanken Grotesk | Source Serif 4 (for body) | JetBrains Mono, Geist Mono |
| Marketing, landing pages | General Sans, Satoshi, Cabinet Grotesk, Geist | Fraunces, Instrument Serif, Newsreader | Berkeley Mono (commercial) |
| Editorial, content-heavy | Inter Tight, Söhne, Söhne Breit | Source Serif 4, Newsreader, EB Garamond | Berkeley Mono, JetBrains Mono |
| Brand, expressive | Cabinet Grotesk, Boogy Brut, PP Editorial New | Fraunces (variable), PP Editorial New | — |
| Brutalist / raw | Helvetica, Inter (yes, here), Departure Mono | Times New Roman (yes, intentionally) | Departure Mono |

Pair a sans with a serif for editorial work. Pair a single high-quality sans with a mono for product work. Three families is the maximum; two is usually right.

### Type scale

**For product UI, use a fixed scale, never fluid.** Fluid type makes app interfaces feel unstable across breakpoints — buttons resize, table headers shift, line lengths jump. Reserve fluid type for marketing/editorial.

A reliable product scale (modular, ratio ~1.2):
```
12px  → captions, micro-labels
14px  → secondary body, dense UI
16px  → primary body, default
18px  → emphasis body
20px  → h4
24px  → h3
30px  → h2
36px  → h1
```

A marketing scale can be more expressive (ratio ~1.333 or golden):
```
14, 16, 18, 24, 32, 48, 64, 96, 128
```

Pick the scale once, write it as CSS custom properties or design tokens, and never set arbitrary `font-size: 17px` values anywhere.

### Line height

Lower for headings, higher for body. Specifically:

| Size | Line-height ratio |
| --- | --- |
| Body 14–18px | 1.5–1.6 |
| Small body 12–13px | 1.4–1.5 |
| H1 / display 48px+ | 1.0–1.1 |
| H2 32–48px | 1.1–1.2 |
| H3 24–30px | 1.2–1.3 |

A common mistake: applying body line-height (1.5) to a 48px headline. It creates yawning gaps and the headline reads as five separate lines instead of one statement.

### Tracking (letter-spacing)

- **Large display type (48px+):** Slight negative tracking, -0.01em to -0.03em. Counteracts the visual gappiness of large type.
- **Body type:** Default (0). Do not touch it.
- **Small caps and all-caps labels:** Positive tracking, 0.05em to 0.1em. All-caps text without tracking looks cramped.

### Hierarchy

Three weights of hierarchy on any page:
1. **Primary** — the one thing the user should see first. One per viewport.
2. **Secondary** — section heads, calls to action. ~3-5 per viewport.
3. **Tertiary** — body, supporting copy, metadata.

Express hierarchy through **size, weight, and color** in that order of preference. Avoid expressing it through color alone (fails for color-blind users), or through weight alone (rarely strong enough).

## Spacing

### Use a scale. Never set arbitrary pixel values.

A 4px base scale gives you these values: `4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96, 128, 160`. Tailwind's default scale is this. Use it.

The fastest tell of generic AI output: random spacing values like `margin-top: 17px`, `padding: 13px 22px`. If a value is not on the scale, it must be justified — typically because of an optical alignment issue, not because someone picked it from a default.

### Spacing is hierarchical

Related things sit closer together than unrelated things. This is called the **gestalt principle of proximity**, and it is the foundation of layout.

A common failure: a card with `padding: 24px` and the same `gap: 24px` between elements inside it. Now everything inside the card is the same distance from everything else and from the card edge — no grouping.

Correct: card padding is 24px, the gap between the heading and body is 8px, the gap between the body and the action row is 24px. The internal grouping is distinct from the external padding.

### Vertical rhythm

Sections on a page should breathe at consistent intervals. A loose rule:

| Element | Vertical space above |
| --- | --- |
| Section break (large) | 96–160px (marketing) / 48–80px (product) |
| Subsection | 48–64px / 32–40px |
| Within a section | 24–32px / 16–24px |
| Within a component | 8–16px / 8–12px |

The numbers matter less than their consistency. Pick a vertical rhythm and apply it everywhere.

## Color

### Use OKLCH for any color system you author

`oklch()` is the modern standard for color in CSS. It gives perceptually uniform lightness — meaning `oklch(50% ...)` looks equally bright across hues, which `hsl()` does not. This matters for:

- Building tinted neutrals that feel like a real palette, not gray with a hue dropped on top.
- Generating accessible variants of a brand color.
- Hover states that look like the original color, just slightly different.

```css
:root {
  --brand: oklch(60% 0.18 250);
  --brand-hover: oklch(56% 0.18 250);  /* same hue and chroma, less light */
  --bg: oklch(98% 0.005 250);          /* tinted neutral, same hue family */
  --text: oklch(20% 0.02 250);
}
```

### Palette strategy

For most sites, the palette is:
- One neutral scale (tinted toward the brand hue, not pure gray)
- One brand color, used sparingly for primary action and one or two accents
- One semantic set: success, warning, error, info

That is **four to six colors**. Not eight, not twelve. If you find yourself reaching for a third "accent", you usually want a typographic distinction instead.

### Hard color rules

- **No pure black (#000) for body text.** Use a deep neutral like `oklch(20% 0.02 250)`. Pure black is harsh on white and signals lazy defaults.
- **No pure white (#FFF) backgrounds for content surfaces.** A 1–2% tinted off-white is more refined.
- **Contrast ratios: 4.5:1 minimum for body text, 3:1 for large text.** Test, do not guess. Tools: `npx tailwindcss-contrast-check`, browser devtools accessibility panel.
- **No gradients in text.** Almost always reads as AI-generated. Exception: a single brand mark where the gradient is the brand.
- **No purple → blue gradients on hero sections.** Or pink → orange. Or any of the dozen variants. They are recognizable on sight.

## Layout

### Pick a grid and respect it

A 12-column grid is the safe default for marketing. A 6-column grid for product. Either way, define column widths, gutter widths, and stick to them.

**Asymmetric does not mean random.** A landing page that uses a 7/5 column split feels more designed than one that centers everything in a 6-column wide block. But the 7 and the 5 still align to the grid.

### Alignment

- Headings and body within the same column should share a baseline alignment, not be center-aligned to each other.
- Avoid center-aligning long paragraphs. Center is for short, declarative copy.
- Optical alignment > mathematical alignment. A button icon may need to be offset by 1px to feel centered next to the label.

### Responsive

Layouts should **change**, not just resize, between breakpoints.

- A 3-column card grid on desktop usually becomes a vertical stack on mobile, **not** a 1-column grid with the same cards stretched to full width.
- Navigation usually changes structure on mobile (hamburger or bottom nav), not just shrinks.
- Type scale steps down meaningfully on mobile. Headlines that are 64px on desktop are usually 36–40px on mobile, not 60px.

Breakpoint defaults that work for most sites:
```
sm: 640px   (large phones)
md: 768px   (tablets)
lg: 1024px  (small laptops)
xl: 1280px  (desktops)
2xl: 1536px (large displays — design for content, not for max width)
```

### Hero sections

The lazy AI default is: centered headline, centered subhead, centered CTA, hero image below. Almost every AI-generated landing page is this layout.

Better defaults:
- Left-aligned headline with the CTA and image on the right (asymmetric).
- Headline that breaks across two or three intentional lines, not wraps naturally.
- A real product visual, not a stock photo or generic abstract gradient.

## Borders, radius, and shadows

- **Border radius:** pick one or two values for the whole site (e.g., `4px` for small, `12px` for cards). The chaos of 4px, 6px, 8px, 10px radii mixed across a single page is a tell.
- **Borders:** prefer `1px solid oklch(... / 0.08)` — a near-invisible tinted border — over hard gray lines. Or use background contrast instead of borders.
- **Shadows:** layered, not single. A real shadow is two or three stacked shadows at different blur radii:
  ```css
  box-shadow:
    0 1px 2px rgba(0,0,0,0.04),
    0 4px 12px rgba(0,0,0,0.06),
    0 16px 32px rgba(0,0,0,0.04);
  ```
  Avoid the default `box-shadow: 0 4px 6px rgba(0,0,0,0.1)` Tailwind shadow. It is everywhere.

## The polish checklist

Before claiming a UI is polished, every item below must pass.

- [ ] All spacing values are on the 4px scale (with documented exceptions).
- [ ] Type scale is defined, applied consistently, and never overridden with arbitrary `font-size` values.
- [ ] Line-height is calibrated per size (lower for large, higher for small).
- [ ] No pure black, no pure white in content areas.
- [ ] All text passes WCAG AA contrast.
- [ ] Border radius uses 1–2 values, applied consistently.
- [ ] Shadows are layered, not flat.
- [ ] Layouts change (not just resize) at breakpoints.
- [ ] No `Inter` unless explicitly chosen for a reason.
- [ ] Hero is not center-stack-center-image.
- [ ] No gradient text, no purple-blue gradients.

## References

- `references/type-scales.md` — extended type-scale ratios and examples
- `references/oklch-palettes.md` — building palettes in OKLCH

## Credits

The structural and typographic discipline here draws on the publicly published work of Paul Bakaus (Impeccable) and the broader frontend design community. Content is an original synthesis. For the source material directly, see https://github.com/pbakaus/impeccable.
