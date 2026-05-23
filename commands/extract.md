---
description: Pull repeated patterns into reusable components and design tokens
argument-hint: [path or directory]
---

# /extract

Find duplicated patterns and lift them into shared components, design tokens, or utility classes.

## Target

$ARGUMENTS

## Procedure

1. **Scan for repetition.** Look for:
   - The same JSX/HTML structure with minor variations (3+ instances)
   - The same set of Tailwind utility classes used together repeatedly
   - The same color literal appearing in multiple places
   - The same spacing combination (`pt-4 pb-6 px-8`) repeated
   - The same animation config (duration, easing) repeated
2. **Promote to tokens.** For values used 3+ times:
   - Colors → CSS custom properties in `:root`
   - Spacing → design tokens or theme extensions
   - Type → CSS variables or theme tokens
   - Animation timings/easings → tokens
3. **Promote to components.** For JSX structures used 3+ times:
   - Extract to a single component with props for the variation
   - Place in a logical directory (`components/ui/`, `components/marketing/`, etc.)
   - Use the same naming convention as the existing codebase
4. **Preserve flexibility.** Do not over-abstract. A component used twice in slightly different ways often should stay duplicated. Abstract only when the cost of duplication is real.
5. **Update consumers.** Rewrite all callsites to use the new tokens/components. Verify visual parity before claiming done.

## Output

```
## Extract complete

**New tokens:**
  - [name → value, used in N places]

**New components:**
  - [Name (props) — used in N places]

**Files modified:** [list]
**Visual changes:** None (or note any intentional changes)
```

If any extraction would change visible output, call it out explicitly. The user should expect visual parity by default.
