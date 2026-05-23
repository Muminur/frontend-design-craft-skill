---
description: Fix layout — spacing, alignment, grid, visual rhythm
argument-hint: [path or "current file"]
---

# /arrange

Diagnose and fix layout problems specifically. Do not touch type, color, or motion.

## Target

$ARGUMENTS

## Procedure

1. **Spacing audit.** List every spacing value used. If any are off the 4px scale (`4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96`), flag them and replace unless there is an explicit optical-alignment reason.
2. **Proximity check.** For each grouped element (card, list item, form field), verify that internal spacing is *tighter* than external spacing. Failure: card padding 24px and internal gap 24px (no visual grouping). Fix: padding 24px, internal gap 8–12px.
3. **Vertical rhythm.** Pick section, subsection, and within-section spacing values and apply consistently:
   - Section break: 96–160px (brand) / 48–80px (product)
   - Subsection: 48–64px / 32–40px
   - Within section: 24–32px / 16–24px
4. **Grid check.** Is there a stated grid (12-col, 6-col, custom)? Are elements aligning to it? If layout feels random, define and apply a grid.
5. **Hero check.** If the page has a hero, is it the lazy centered-stack-with-image-below pattern? If so, propose an asymmetric layout option (e.g., 7/5 split, headline left + product image right).
6. **Responsive check.** Do layouts *change* between breakpoints, or just resize? A 3-column desktop grid should not become a stretched 1-column grid on mobile — it should restructure (vertical stack, horizontal scroll, or different component entirely).
7. **Alignment check.** Look for optical mis-alignments (icon next to label, button text, heading-to-body baselines).

## Output

```
## Arrange complete

**Spacing scale enforced:** [scale]
**Vertical rhythm:** [section/subsection/within values]
**Grid:** [columns / gutter]

**Issues fixed:**
  - [list]

**Layout changes:**
  - [list of structural changes — e.g., "hero restructured to 7/5 asymmetric"]
```

If a hero restructure is proposed, show the user the before/after structure (in words or ASCII) before implementing.
