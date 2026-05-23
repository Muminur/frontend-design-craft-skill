---
description: Full design audit of the current page, component, or codebase
argument-hint: [path or URL or "current file"]
---

# /audit

Run a structured design audit across motion, polish, and taste. Report only — do not fix anything in this pass.

## Target

$ARGUMENTS

If no target is given, audit the most recently discussed file or, if there is none, ask the user what to audit.

## Procedure

1. **Determine mode.** Look at the target. Is it a marketing/brand page or a product/app UI? State which.
2. **Determine archetype.** If the design has a clear archetype already (editorial, soft-premium, brutalist, expressive, technical), name it. If it does not, note that as a finding.
3. **Run each lens.** For each of the three lenses below, list findings with severity (`CRITICAL` / `HIGH` / `MEDIUM` / `LOW`).

### Lens 1 — Polish (typography, spacing, layout, color)

Check every item in the polish checklist (see `skills/polish/SKILL.md`):
- Spacing values on a consistent scale
- Type scale defined and applied
- Line-height calibrated per size
- No pure black/white in content
- WCAG AA contrast
- Border radius / shadow consistency
- Layouts change vs. resize at breakpoints

### Lens 2 — Taste (anti-slop)

Check the ban list:
- Purple-blue / pink-orange gradients
- Glassmorphism / frosted glass cards
- Gradient text
- `Inter` as default sans
- Centered hero with stacked CTA + image below
- Three equal-column feature grid
- shadcn/ui defaults unmodified
- `John Doe`, `Lorem ipsum`, fake stats
- Stock photos / generic Unsplash imagery
- Bento grids without visual variation

### Lens 3 — Motion

- Animations communicate state vs. decorate
- Easing curves consistent across related elements
- Timing matches weight of change
- `prefers-reduced-motion` respected
- Only `transform` / `opacity` animated
- No `transition: all`

## Output format

```
## Audit: [target]

**Mode:** [brand | product]
**Archetype:** [name, or "undefined — pick one"]
**Dials (inferred):** VARIANCE: x, MOTION: y, DENSITY: z

### CRITICAL (must fix before ship)
1. [issue] — [location] — [why it matters]
2. ...

### HIGH (visible quality drag)
...

### MEDIUM
...

### LOW (nice to have)
...

## Recommended next steps
1. Run `/typeset` to address typography findings
2. Run `/arrange` to address spacing findings
3. Run `/anti-slop` to address generic patterns
```

End with: "Run `/polish` when ready to apply fixes, or call specific commands for targeted changes."
