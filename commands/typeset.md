---
description: Fix typography — fonts, type scale, line-height, hierarchy
argument-hint: [path or "current file"]
---

# /typeset

Diagnose and fix typography problems specifically. Do not touch layout, color, or motion unless they are blocking a typographic fix.

## Target

$ARGUMENTS

## Procedure

1. **Identify the current type system.** What fonts are loaded? What sizes appear? What weights? Are there arbitrary `font-size` values?
2. **Determine mode** (brand or product) — this dictates whether to use fluid or fixed type scales.
3. **Replace generic font choices.** If `Inter` is the default sans without justification, propose a substitute appropriate to the archetype:
   - Editorial/restrained: Geist, Söhne, IBM Plex Sans
   - Soft/premium: General Sans, Cabinet Grotesk + Fraunces
   - Brutalist: Helvetica, Departure Mono
   - Expressive: Cabinet Grotesk, PP Editorial New
   - Technical: Geist + Geist Mono
4. **Define a type scale** as CSS variables or design tokens. Modular ratio ~1.2 for product, ~1.333 for marketing. Remove all arbitrary sizes.
5. **Calibrate line-height per size:**
   - Display 48px+ → 1.0–1.1
   - H2 32–48px → 1.1–1.2
   - H3 24–30px → 1.2–1.3
   - Body 14–18px → 1.5–1.6
   - Small 12–13px → 1.4–1.5
6. **Calibrate tracking:**
   - Display (48px+): -0.01 to -0.03em
   - Body: 0 (default)
   - All-caps labels: +0.05 to +0.1em
7. **Verify hierarchy.** One primary heading per viewport, secondary level used 3–5 times, tertiary for body. Express via size+weight+color, not color alone.

## Output

Before/after of the type system, summarized:

```
## Typeset complete

**Font stack:**
  Before: [list]
  After:  [list]

**Type scale:**
  [tokens]

**Line-height:**
  [per size]

**Changes applied:**
  - [list of files and what changed]
```

Ask the user to confirm the font choice before touching anything if there is real ambiguity about the archetype.
