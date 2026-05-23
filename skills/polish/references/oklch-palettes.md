# OKLCH Palettes — Extended Reference

`oklch()` is the modern color space for CSS color systems. Unlike HSL, it gives perceptually uniform lightness — `oklch(50% c h)` looks equally bright across all hues. This makes it possible to build palettes that actually feel coherent.

## Syntax

```css
oklch(L C H / alpha)
```

- **L** — lightness, 0% to 100% (perceptually uniform)
- **C** — chroma (saturation), 0 to ~0.4 in practice
- **H** — hue, 0 to 360 degrees
- **alpha** — optional, 0 to 1

## Hue reference

| Hue (degrees) | Color family |
| --- | --- |
| 0–25 | Red |
| 25–55 | Orange, terracotta |
| 55–95 | Yellow, gold |
| 95–145 | Green |
| 145–195 | Teal, cyan |
| 195–250 | Blue |
| 250–290 | Indigo, purple |
| 290–340 | Magenta, pink |
| 340–360 | Crimson, rose |

## Building a tinted neutral scale

The trick: same hue as the brand, very low chroma (0.005 – 0.02), distributed lightness stops.

```css
:root {
  /* Tinted neutrals — built around brand hue (here: blue 250°) */
  --neutral-0:   oklch(99% 0.003 250);
  --neutral-50:  oklch(97% 0.005 250);
  --neutral-100: oklch(94% 0.008 250);
  --neutral-200: oklch(89% 0.010 250);
  --neutral-300: oklch(81% 0.012 250);
  --neutral-400: oklch(70% 0.015 250);
  --neutral-500: oklch(58% 0.018 250);
  --neutral-600: oklch(46% 0.020 250);
  --neutral-700: oklch(36% 0.020 250);
  --neutral-800: oklch(26% 0.018 250);
  --neutral-900: oklch(18% 0.015 250);
  --neutral-950: oklch(12% 0.010 250);
}
```

This gives "warm-blue grays" that feel like a real palette, not stock gray with a tint slapped on.

## Brand color and states

```css
:root {
  --brand:        oklch(60% 0.18 250);
  --brand-hover:  oklch(56% 0.18 250);   /* same hue + chroma, less light */
  --brand-active: oklch(52% 0.18 250);
  --brand-soft:   oklch(95% 0.05 250);   /* tinted bg for soft callouts */
}
```

Using `oklch()` `from` syntax (modern browsers) lets you derive states:

```css
:root {
  --brand: oklch(60% 0.18 250);
  --brand-hover: oklch(from var(--brand) calc(l - 4%) c h);
  --brand-active: oklch(from var(--brand) calc(l - 8%) c h);
}
```

## Semantic colors

Pick perceptually-matched lightness across semantics so they feel like one set.

```css
:root {
  --success: oklch(60% 0.15 145);   /* green */
  --warning: oklch(70% 0.15 75);    /* gold */
  --error:   oklch(58% 0.20 25);    /* red */
  --info:    oklch(60% 0.15 230);   /* blue */

  /* Soft variants for backgrounds */
  --success-soft: oklch(95% 0.05 145);
  --warning-soft: oklch(95% 0.05 75);
  --error-soft:   oklch(95% 0.05 25);
  --info-soft:    oklch(95% 0.05 230);
}
```

## Archetype palettes

### Editorial / Restrained (Linear-style)

```css
--bg:        oklch(99% 0.003 250);
--surface:   oklch(97% 0.005 250);
--border:    oklch(89% 0.008 250);
--text:      oklch(22% 0.015 250);
--text-soft: oklch(50% 0.015 250);
--brand:     oklch(55% 0.18 250);    /* used sparingly */
```

### Soft / Premium (warm)

```css
--bg:        oklch(97% 0.012 75);    /* warm cream */
--surface:   oklch(94% 0.015 75);
--border:    oklch(86% 0.018 75);
--text:      oklch(25% 0.025 30);    /* deep warm brown */
--text-soft: oklch(50% 0.025 30);
--brand:     oklch(55% 0.12 30);     /* muted terracotta */
```

### Brutalist

```css
--bg:        oklch(100% 0 0);        /* pure white */
--text:      oklch(0% 0 0);          /* pure black, intentional */
--accent:    oklch(58% 0.25 25);     /* one saturated accent */
--border:    oklch(0% 0 0);          /* black borders */
```

### Technical / Engineered

```css
--bg:        oklch(99% 0.003 250);
--surface:   oklch(96% 0.005 250);
--border:    oklch(90% 0.008 250);
--text:      oklch(20% 0.015 250);
--text-soft: oklch(45% 0.015 250);
--brand:     oklch(58% 0.20 250);    /* saturated, clear */
--mono-bg:   oklch(20% 0.015 250);   /* code blocks */
```

## Contrast checking

WCAG AA requires:
- 4.5:1 minimum for body text
- 3:1 minimum for large text (18px+ regular, 14px+ bold)

OKLCH does not directly tell you contrast — use a contrast checker. Browser devtools accessibility panel will warn you, or tools like:
- `npx wcag-contrast-tester`
- Stark plugin in design tools
- contrast-ratio.com

Approximate rule of thumb: a 50% L difference is usually enough for AA contrast, but always verify.

## Browser support

`oklch()` is supported in all modern browsers (Chrome 111+, Safari 15.4+, Firefox 113+). For older browsers, provide fallback:

```css
.brand {
  background: #4d6bff;                /* fallback for very old browsers */
  background: oklch(60% 0.18 250);
}
```

In 2026, fallbacks are rarely necessary except for legacy enterprise environments.
