# Type Scales — Extended Reference

A type scale is a fixed set of font sizes derived from a ratio. Using a scale (rather than arbitrary sizes) is the single fastest way to make typography feel intentional.

## Choosing a ratio

| Ratio | Name | Use for |
| --- | --- | --- |
| 1.067 | Minor second | Dense product UIs where size differences should be subtle |
| 1.125 | Major second | Documentation, content-heavy product UIs |
| 1.200 | Minor third | **Default for product UIs** — clear hierarchy without drama |
| 1.250 | Major third | Marketing pages with moderate hierarchy |
| 1.333 | Perfect fourth | **Default for marketing** — confident, expressive hierarchy |
| 1.414 | Augmented fourth | Editorial, dramatic display sizes |
| 1.500 | Perfect fifth | Brand-heavy, single-message pages |
| 1.618 | Golden ratio | Editorial / artistic — feels classical |

## Product scale (ratio 1.2, base 16px)

```
--text-xs:   12px / 0.75rem    /* line-height: 1.5  (18px) */
--text-sm:   14px / 0.875rem   /* line-height: 1.5  (21px) */
--text-base: 16px / 1rem       /* line-height: 1.5  (24px) — default body */
--text-lg:   18px / 1.125rem   /* line-height: 1.55 (28px) */
--text-xl:   20px / 1.25rem    /* line-height: 1.4  (28px) */
--text-2xl:  24px / 1.5rem     /* line-height: 1.3  (32px) — h4 */
--text-3xl:  30px / 1.875rem   /* line-height: 1.25 (38px) — h3 */
--text-4xl:  36px / 2.25rem    /* line-height: 1.15 (42px) — h2 */
--text-5xl:  48px / 3rem       /* line-height: 1.1  (52px) — h1 */
```

Use fixed `px` or `rem`; do not use `clamp()` fluid sizes in product UI body text.

## Marketing scale (ratio 1.333, base 16px)

```
--text-xs:   12px
--text-sm:   14px
--text-base: 16px         /* body */
--text-lg:   18px
--text-xl:   21px
--text-2xl:  28px
--text-3xl:  37px
--text-4xl:  50px
--text-5xl:  66px
--text-6xl:  88px         /* hero display */
--text-7xl:  117px        /* dramatic display */
```

Marketing display sizes (50px+) can use `clamp()` for fluid scaling:
```css
--text-display: clamp(48px, 8vw, 96px);
```

## Editorial scale (ratio 1.414, base 18px for serif body)

For long-form reading, use a slightly larger base size and a serif for body.

```
--text-caption:  14px
--text-body:     18px / 1.65 line-height  /* generous for reading */
--text-lead:     22px
--text-h3:       28px
--text-h2:       40px
--text-h1:       56px
--text-display:  84px
```

## Line-height per size

| Size | Line-height |
| --- | --- |
| 12–14px | 1.4–1.5 |
| 16–18px (body) | 1.5–1.65 |
| 20–24px | 1.35–1.45 |
| 28–36px | 1.2–1.3 |
| 40–56px | 1.1–1.2 |
| 64px+ | 1.0–1.1 |

## Tracking (letter-spacing) per size

| Size | Tracking |
| --- | --- |
| 12px (caption/UI) | +0.01em |
| 14–18px (body) | 0 (default) |
| 20–30px | 0 to -0.005em |
| 36–48px | -0.01em |
| 56–72px | -0.015em |
| 80px+ | -0.02 to -0.03em |
| All-caps labels (any size) | +0.05 to +0.1em |

## Font weight scale

Pick 3–4 weights. More than that is rarely used coherently.

**Minimal product set:** `400` (body), `500` (UI labels), `600` (headings)

**Marketing set:** `400` (body), `500` (UI), `700` or `800` (display)

**Editorial set:** `400` (body), `400 italic` (emphasis), `600` (subheads), `700` (display)

Avoid:
- `300` for body text — usually too thin for readability except in display sizes
- `900` unless the brand explicitly calls for it
- Loading more than 4 weights of a single family — performance cost

## Examples — applying the scale

### Product UI section

```jsx
<section className="space-y-6">
  <header className="space-y-1">
    <h2 className="text-3xl font-semibold tracking-tight">Account settings</h2>
    <p className="text-base text-neutral-600">Manage your profile and preferences.</p>
  </header>
  {/* ... */}
</section>
```

### Marketing hero

```jsx
<section className="space-y-8">
  <h1 className="text-6xl md:text-7xl font-bold tracking-tight leading-[1.05]">
    Real headline that says what the product does
  </h1>
  <p className="text-xl md:text-2xl text-neutral-700 max-w-2xl leading-relaxed">
    Real subheadline that adds specific information, not "Revolutionize your workflow."
  </p>
</section>
```
