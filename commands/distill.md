---
description: Strip the interface to what earns its place
argument-hint: [path or "current file"]
---

# /distill

Remove. Do not add anything. The goal is fewer elements, fewer colors, fewer fonts, fewer animations — leaving only what carries weight.

## Target

$ARGUMENTS

## Procedure

1. **For each visible element, ask:** does removing this make the product worse, or just smaller? If only smaller, remove it.
2. **For each color in the palette, ask:** is this distinct from the others, or just a variant nobody can name? Collapse near-duplicates.
3. **For each font weight, ask:** is this used in 2+ places, or just once for emphasis? If once, consider replacing with the nearest used weight.
4. **For each animation, ask:** does this signal state, or decorate? If decorate, remove.
5. **For each section, ask:** could this be merged with the section above or below, or removed outright?
6. **For repeated patterns** (3 testimonials, 6 logos, 4 features): is the count chosen, or arbitrary? Often 2 well-chosen items beat 4 average ones.
7. **For copy:** strip qualifiers. "Really fast" → "fast". "Helps you to manage" → "manages". "We believe" → cut.

## Output

```
## Distilled

**Removed:** [list with rationale]
**Merged:** [list]
**Copy tightened:** [before / after snippets]

**Element count:** [before] → [after]
**Color count:** [before] → [after]
**Font weight count:** [before] → [after]
```

Distill is destructive. Confirm with the user before removing anything that took meaningful work to build.
