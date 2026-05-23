---
description: Add or fix motion — animations, transitions, micro-interactions
argument-hint: [path or "current file"]
---

# /animate

Add purposeful motion, or fix existing motion that feels off. Defer to the `motion` skill for principles.

## Target

$ARGUMENTS

## Procedure

1. **Inventory existing motion.** List every `transition`, `animation`, `motion` component, or `framer-motion` usage. For each, answer: does it communicate state, or is it decorative?
2. **Remove decorative motion.** If an animation does not respond to a user action or signal a state change, propose removing it.
3. **Pick a motion budget.** State the dial: `MOTION: 1–10`. Brand sites can run 5–8. Product UIs should be 2–4. Stick to it.
4. **Standardize easing.** Pick a small set (typically 2–3 curves) and apply consistently. A reliable starter set:
   - Standard entrance: `cubic-bezier(0.16, 1, 0.3, 1)`
   - Standard exit: `cubic-bezier(0.7, 0, 0.84, 0)`
   - Spring for direct manipulation: `{ type: "spring", stiffness: 400, damping: 30 }`
5. **Calibrate duration to weight:**
   - Hover color: 100–150ms
   - Button press: 100–200ms
   - Tooltip / popover: 150–200ms
   - Dropdown / menu: 200–250ms
   - Modal / drawer: 250–400ms (enter), 200–300ms (exit)
   - Page transition: 300–500ms
6. **Replace forbidden property animations.** Any animation of `width`, `height`, `top`, `left`, `margin`, `padding` gets converted to `transform` / `opacity`.
7. **Set `transform-origin` correctly.** Dropdowns scale from their trigger. Modals scale from center. Toasts slide in from their edge.
8. **Stagger sparingly.** 3–4 elements at 30–50ms intervals is alive. 10+ elements at any interval is buffering.
9. **Add `prefers-reduced-motion` coverage.** Either a global suppression or per-component `@media` guards.
10. **Replace `transition: all`** with explicit property lists.

## Output

```
## Animate complete

**Motion dial:** [n]/10
**Easing set:**
  - Entrance: [curve]
  - Exit: [curve]
  - Spring: [config]

**Added animations:** [list]
**Removed (decorative):** [list]
**Converted to transform/opacity:** [list]
**Reduced-motion coverage:** [yes/no]
```

If the user has not specified the motion budget, ask before doing anything heavy.
