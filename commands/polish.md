---
description: Final pre-ship pass — apply all three lenses to fix the target
argument-hint: [path or "current file"]
---

# /polish

Apply fixes across motion, polish, and taste. This is the inverse of `/audit`: change the code, do not just report on it.

## Target

$ARGUMENTS

## Procedure

Apply fixes in this strict order. Skipping ahead will produce inferior results.

### Pass 1 — Polish (structural)

Fix anything in the foundation before touching aesthetics or motion:

1. Normalize spacing to a single scale (default 4px base).
2. Define or normalize a type scale; remove any arbitrary `font-size` values.
3. Calibrate line-height per size (lower for large headings, higher for body).
4. Replace pure black and pure white with tinted neutrals.
5. Verify and fix contrast to WCAG AA minimum.
6. Reduce border radius and shadow values to a coherent set (1–2 radii, layered shadows).
7. Verify breakpoints actually change layout, not just rescale.

### Pass 2 — Taste (aesthetic)

Once structure is sound:

1. Strip banned patterns (purple-blue gradients, glassmorphism, gradient text, default Inter, default shadcn theme, etc. — see `skills/taste/SKILL.md`).
2. Replace placeholder content (`Lorem ipsum`, `John Doe`, fake stats, stock photos).
3. Confirm or pick an archetype; align the design to it.
4. Override default icon library settings if used unchanged.

### Pass 3 — Motion

With structure and taste in place:

1. Audit every existing animation: does it communicate something or decorate?
2. Make easing consistent across related elements.
3. Calibrate timing to perceived weight (see `skills/motion/SKILL.md`).
4. Convert any animated layout properties (`width`, `height`, `margin`) to `transform` / `opacity`.
5. Add `prefers-reduced-motion` coverage.

## Output

After each pass, summarize what was changed in 3–5 bullets. After all three passes:

```
## Polish complete

**Files modified:** [list]
**Pass 1 — Polish:** [n] changes
**Pass 2 — Taste:** [n] changes
**Pass 3 — Motion:** [n] changes

**Open questions for the user:**
- [anything that required a judgment call]
```

Do not skip the open-questions section. If everything was unambiguous, say so explicitly.
