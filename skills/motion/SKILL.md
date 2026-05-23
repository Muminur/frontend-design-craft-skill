---
name: motion
description: Purposeful web animation. Use when the user wants to add, fix, audit, or reason about animation, transitions, easing, micro-interactions, hover effects, scroll-triggered motion, modals, drawers, toasts, or any movement on a website. Triggers on "animate", "transition", "smoother", "feels janky", "spring", "ease", "stagger", "page transition", or any motion-related request.
---

# Motion

Animation should feel inevitable, not decorative. The best motion on the web is the kind users do not notice — it makes the interface feel responsive and physical, then gets out of the way. The worst motion is the kind that calls attention to itself: bouncy entrances on every element, decorative scroll effects, parallax for its own sake.

## The four questions before adding any animation

1. **Does this animation communicate something?** State changes (open/closed, loading/loaded, selected/deselected) deserve motion. Pure decoration does not.
2. **Does the user trigger it, or does it happen to them?** User-triggered animations can be slightly longer (200–400ms). Animations that happen passively (entrance animations, scroll effects) must be shorter or removed entirely.
3. **What is the physical metaphor?** Things falling use ease-in. Things settling use ease-out. Things being pushed use spring physics. If no physical metaphor fits, the animation probably should not exist.
4. **What happens if `prefers-reduced-motion` is on?** Have the answer before you start.

## Properties to animate

**Animate freely:**
- `transform` (translate, scale, rotate)
- `opacity`
- `filter` (with care — expensive)
- `clip-path` (with care)

**Never animate directly:**
- `width`, `height`, `top`, `left`, `right`, `bottom`, `margin`, `padding` — these trigger layout. Use transforms instead.
- `box-shadow` — animate a pseudo-element's opacity instead, or pre-render shadow states.
- `background-color` on large surfaces — use a pseudo-element overlay if it must move.

If you find yourself reaching for `width: 0 → width: 300px`, the right answer is almost always `transform: scaleX(0) → scaleX(1)` with the correct `transform-origin`.

## Timing

Match duration to perceived weight of the change. These are starting points, not rules:

| What | Duration | Why |
| --- | --- | --- |
| Color change on hover | 100–150ms | Should feel instant but not abrupt |
| Button press, tap response | 100–200ms | Confirms input received |
| Tooltip, popover open | 150–200ms | Light, transient |
| Dropdown, menu open | 200–250ms | Medium presence |
| Modal, drawer open | 250–400ms | Heavy, demands attention |
| Page transition | 300–500ms | Largest scope change |
| Hero entrance animations | 400–600ms | Once-per-session moments |

Two more rules:
- **Exit is usually faster than entry.** Entering: 300ms. Exiting: 200ms. The user has already decided to dismiss it.
- **The longer the duration, the more wrong easing becomes.** A bad curve at 150ms is forgivable. At 500ms it is the dominant impression.

## Easing

For most production work, three families cover ~95% of cases.

**Standard easing (for state changes that have weight)**
```css
/* Linear-out, ease-in - things arriving */
cubic-bezier(0.16, 1, 0.3, 1)

/* Ease-in, linear-out - things leaving */
cubic-bezier(0.7, 0, 0.84, 0)

/* Symmetric - things moving */
cubic-bezier(0.65, 0, 0.35, 1)
```

**Spring physics (for direct manipulation and natural motion)**

Use `framer-motion`'s spring config or CSS `linear()` approximation. Springs feel right for: things following a finger, things settling into place, things being released.
```js
// Motion / Framer Motion
transition: { type: "spring", stiffness: 400, damping: 30 }
```

**Avoid:**
- Default browser `ease` for anything > 200ms — it looks lazy.
- Bounce easing on UI elements (overshoot is fine; bounce is cartoonish).
- `linear` for anything except continuous motion (spinners, marquees, progress bars).

## Choreography — coordinating multiple animations

When two or more things animate together, they must agree.

1. **Shared easing.** A modal and its backdrop must use the same curve. A menu item and its icon must use the same curve.
2. **Stagger sparingly.** Staggering 3 menu items by 30ms feels alive. Staggering 12 items by 50ms feels like the page is buffering.
3. **Origin matters.** A dropdown should scale from its trigger (`transform-origin: top left` if the trigger is top-left of the menu). A modal should scale from center. A toast should slide in from the edge it lives on.
4. **One hero element at a time.** If three things animate on page load, two are too many.

## Reduced motion

Required, not optional. Wrap any decorative animation:

```css
@media (prefers-reduced-motion: no-preference) {
  .card { transition: transform 200ms cubic-bezier(0.16, 1, 0.3, 1); }
}
```

Or globally suppress with a fallback:

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

State changes (modal open, dropdown expand) should still happen — just instantly. Do not remove the affordance, just the motion.

## Performance

- Use `will-change` only when an animation is imminent. Add it on hover or focus, remove it on transition end. Leaving it on permanently is a deopt.
- Test on a mid-range Android device. The animation that feels great on a recent Mac will stutter on a $200 phone.
- Avoid animating layout properties during scroll. Mobile browsers struggle.
- Compositor-only properties (`transform`, `opacity`, `filter`) avoid layout thrash. Stay on these.

## Common patterns done right

**Hover lift on a card**
```css
.card {
  transition: transform 200ms cubic-bezier(0.16, 1, 0.3, 1),
              box-shadow 200ms cubic-bezier(0.16, 1, 0.3, 1);
}
.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 30px -10px rgba(0,0,0,0.15);
}
```

**Modal enter**
```js
// Framer Motion
<motion.div
  initial={{ opacity: 0, scale: 0.96 }}
  animate={{ opacity: 1, scale: 1 }}
  exit={{ opacity: 0, scale: 0.98 }}
  transition={{ duration: 0.25, ease: [0.16, 1, 0.3, 1] }}
/>
```

**Dropdown / popover from trigger**
```js
<motion.div
  initial={{ opacity: 0, y: -4, scale: 0.98 }}
  animate={{ opacity: 1, y: 0, scale: 1 }}
  exit={{ opacity: 0, y: -4, scale: 0.98 }}
  transition={{ duration: 0.15, ease: [0.16, 1, 0.3, 1] }}
  style={{ transformOrigin: "top" }}
/>
```

**Toast from edge**
```js
<motion.div
  initial={{ x: "100%", opacity: 0 }}
  animate={{ x: 0, opacity: 1 }}
  exit={{ x: "100%", opacity: 0 }}
  transition={{ type: "spring", stiffness: 400, damping: 35 }}
/>
```

## Anti-patterns — animations that signal "AI generated"

- **Every section fades up on scroll.** Reserve scroll-triggered animation for one or two key moments.
- **Bouncing arrows / "scroll down" indicators.**
- **Decorative parallax on background images.** It just feels broken on Safari.
- **Hover effects with `transition: all`.** Be explicit about which properties.
- **Float-up entrance animations on cards that load instantly.** If the data is already there, do not pretend it is loading.
- **Magnetic cursors** unless the brand specifically calls for it.

## References

- `references/timing-and-easing.md` — extended curve library
- `references/choreography-examples.md` — multi-element coordination patterns

## Credits

This skill's animation philosophy draws on the publicly published work of Emil Kowalski (animations.dev, Sonner, Vaul) and the broader motion design community. Content here is an original synthesis. If you want the source material directly, see https://emilkowal.ski/skill and https://animations.dev.
