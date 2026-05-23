---
description: Tone down a too-loud, over-decorated design
argument-hint: [path or "current file"]
---

# /quieter

The design is fighting for attention. Too many colors, too many fonts, too many animations, too much shadow. Calm it.

## Target

$ARGUMENTS

## Procedure

1. **Diagnose the loud.** Common offenders:
   - More than 2 brand colors used as primary fills
   - 3+ font families
   - 4+ font weights in heavy use
   - Drop shadows on most elements
   - Gradients beyond a single brand moment
   - Animations on entrance for most elements
   - Borders + shadows + background contrast all used together
2. **Reduce palette.** Collapse to neutrals + one brand color + semantic colors. Move secondary "accents" to tinted neutrals.
3. **Reduce font load.** Down to one or two families, three weights maximum (e.g., 400 / 500 / 700).
4. **Remove shadows where contrast already exists.** If a card has a background different from the page, it does not also need a shadow.
5. **Replace gradients with solid color.** Keep at most one gradient moment per page, if any.
6. **Strip entrance animations.** Keep only state-change animation.
7. **Increase whitespace.** Loudness often correlates with cramping. Push spacing up.

## Output

```
## Quieter

**Palette:** [before count] → [after count]
**Fonts:** [before] → [after]
**Shadows removed:** [list]
**Gradients removed:** [list]
**Animations removed:** [list]
**Whitespace increases:** [where]
```
