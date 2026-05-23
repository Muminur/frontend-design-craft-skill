# Timing and Easing — Extended Reference

## Duration cheat sheet

| Interaction | Range | Default | Notes |
| --- | --- | --- | --- |
| Color/opacity hover | 80–150ms | 120ms | Should feel instant |
| Button press feedback | 100–200ms | 150ms | Confirms input |
| Icon state toggle | 150–250ms | 200ms | Smooth, not snappy |
| Tooltip / popover open | 150–250ms | 180ms | Lightweight |
| Tooltip / popover close | 100–150ms | 120ms | Faster than open |
| Dropdown / menu open | 200–280ms | 220ms | |
| Dropdown / menu close | 150–200ms | 160ms | |
| Modal open | 280–400ms | 320ms | Demands attention |
| Modal close | 200–280ms | 220ms | Faster exit |
| Drawer open | 300–450ms | 360ms | Spring-friendly |
| Drawer close | 240–320ms | 260ms | |
| Toast in | 280–400ms | 320ms | Spring works well |
| Toast out | 200–280ms | 220ms | |
| Page transition | 300–500ms | 380ms | Brand sites only |
| Hero entrance | 400–700ms | 500ms | Once per session |
| Scroll-triggered reveal | 400–600ms | 500ms | Use sparingly |

**Rule of thumb:** exit is 60–80% of entry duration. The user has already committed to dismissing it.

## Cubic-bezier library

Copy these as needed. Save them as design tokens if used in 3+ places.

### Standard

```css
/* Out-expo — entrances. Starts fast, decelerates smoothly. */
--ease-out: cubic-bezier(0.16, 1, 0.3, 1);

/* In-expo — exits. Starts slow, accelerates away. */
--ease-in: cubic-bezier(0.7, 0, 0.84, 0);

/* In-out — symmetric motion through space. */
--ease-in-out: cubic-bezier(0.65, 0, 0.35, 1);
```

### Sharper alternatives

```css
/* Out-quart — slightly snappier than out-expo */
--ease-out-quart: cubic-bezier(0.25, 1, 0.5, 1);

/* In-out-quart — for elements that need a bit of decisiveness */
--ease-in-out-quart: cubic-bezier(0.76, 0, 0.24, 1);
```

### Material-style standard

```css
/* Material Design standard curve — when consistency with M3 matters */
--ease-material: cubic-bezier(0.2, 0, 0, 1);
```

### To avoid

- Browser default `ease` for anything > 200ms — looks lazy
- `linear` for anything except continuous motion (spinners, marquees)
- Overshoot beyond ~5% on UI elements (`cubic-bezier(0.34, 1.56, 0.64, 1)` is acceptable for playful contexts; anything bouncier reads cartoonish)

## Spring physics

For natural, physical motion — especially direct-manipulation interactions.

### Framer Motion / Motion

```js
// General-purpose UI spring
{ type: "spring", stiffness: 400, damping: 30 }

// Snappier — for buttons, toggles
{ type: "spring", stiffness: 500, damping: 35 }

// Slower, more contemplative — for hero or page moments
{ type: "spring", stiffness: 280, damping: 32 }

// Bouncy — use sparingly
{ type: "spring", stiffness: 400, damping: 18 }
```

`stiffness` controls how forcefully the spring pulls toward the target. `damping` controls how much it resists overshoot. Higher damping = less bounce.

### CSS `linear()` approximations

When CSS is the only option, `linear()` can simulate a spring:

```css
/* Approximate spring(stiffness: 400, damping: 30) */
transition-timing-function: linear(
  0, 0.027, 0.105, 0.227, 0.379, 0.546, 0.711,
  0.859, 0.977, 1.059, 1.103, 1.115, 1.103,
  1.080, 1.052, 1.025, 1.005, 0.993, 0.989, 0.991,
  0.996, 1
);
```

Generators exist (e.g., linear-easing-generator) — do not handcraft these.

## Choreography templates

### Stagger (3–4 items)

```js
const container = {
  animate: { transition: { staggerChildren: 0.04 } }
};
const item = {
  initial: { opacity: 0, y: 8 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.3, ease: [0.16, 1, 0.3, 1] }}
};
```

### Layout transition (FLIP-style)

```js
// framer-motion's `layout` prop handles this automatically
<motion.div layout transition={{ duration: 0.3, ease: [0.16, 1, 0.3, 1] }}/>
```

### Sequenced reveal

```js
// Avoid orchestration past 3-4 keyframes. If you need more, you are decorating.
const sequence = async () => {
  await controls.start({ opacity: 1, transition: { duration: 0.25 }});
  await controls.start({ y: 0, transition: { duration: 0.3, ease: [0.16, 1, 0.3, 1] }});
};
```

## Performance notes

- Animate `transform` and `opacity` only. Other properties trigger layout/paint.
- Promote elements with `will-change: transform` *only* immediately before animating; remove on `transitionend`.
- For scroll-driven animations, use `IntersectionObserver` (cheap) or CSS `animation-timeline` (newer, very cheap), not scroll-event listeners.
- Test on a mid-range Android. A $200 phone is the floor your animation must clear.
