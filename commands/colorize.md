---
description: Introduce or rework color strategy
argument-hint: [path or "current file"]
---

# /colorize

Build or fix a color system. Author in OKLCH; ship as CSS custom properties.

## Target

$ARGUMENTS

## Procedure

1. **Identify the brand color.** If unclear, ask the user. Avoid defaulting to blue.
2. **Build the palette.** A complete palette for most sites is 4–6 colors:
   - **Tinted neutral scale** — 8–10 stops, all sharing the brand hue at very low chroma (`oklch(98% 0.005 H)` to `oklch(15% 0.02 H)` where `H` is the brand hue).
   - **Brand color** — used sparingly for primary action, one or two accents.
   - **Semantic set** — success, warning, error, info. Each at 2–3 lightness stops.
3. **Check perceptual uniformity.** OKLCH lets you generate hover/active states by stepping lightness, not by adding black or white. `--brand-hover: oklch(from var(--brand) calc(l - 4%) c h)`.
4. **Verify contrast.** Every text-on-background combination must hit WCAG AA (4.5:1 for body, 3:1 for large). Tools: browser devtools, `contrast-checker` CLIs.
5. **Apply restraint.** The palette has 12 tokens; the page should still feel like it uses 3–4. The rest are for states, not primaries.

## Banned color moves

- Pure `#000` text or `#FFF` backgrounds in content
- Purple → blue, pink → orange, teal → blue gradients
- Using Tailwind default colors (`blue-500`, etc.) directly in components without a semantic alias
- Gradient text
- More than one gradient moment per page

## Output

```css
/* Example output structure */
:root {
  /* Brand */
  --brand: oklch(60% 0.18 250);
  --brand-hover: oklch(56% 0.18 250);
  --brand-active: oklch(52% 0.18 250);

  /* Tinted neutrals (8 stops) */
  --neutral-0: oklch(99% 0.003 250);
  --neutral-50: oklch(96% 0.005 250);
  --neutral-100: oklch(92% 0.007 250);
  /* ... */
  --neutral-900: oklch(18% 0.015 250);

  /* Semantic */
  --success: oklch(60% 0.15 145);
  --warning: oklch(70% 0.15 75);
  --error:   oklch(58% 0.20 25);
  --info:    oklch(60% 0.15 230);
}
```

Show the user the palette as a visual swatch (HTML or markdown table) before applying changes.
