---
description: UX review — hierarchy, clarity, what to remove
argument-hint: [path or "current file"]
---

# /critique

Pure UX review. Identify what does not earn its place, what is unclear, what fights for attention. Report only — pair with `/distill` or `/polish` to act on findings.

## Target

$ARGUMENTS

## Procedure

1. **The squint test.** Look at the screen with eyes squinted. What dominates? Is it the most important thing? If not, hierarchy is broken.
2. **The five-second test.** What does the page communicate in five seconds? Does it match the product's actual proposition?
3. **Cognitive load.** Count the number of decisions the user has to make per screen. More than 3 is usually too many on a marketing page; more than 5–7 on a product UI.
4. **Information architecture.** Is content grouped logically? Are related items near each other? Are unrelated items separated?
5. **What can be removed?** For each element on the screen, ask: if this disappeared, would the user notice? Would the product be worse? If both answers are no, propose removal.
6. **Calls to action.** Is there one primary CTA per viewport? If there are two primaries, one of them is not primary.
7. **Empty states and edge cases.** What happens with no data? With long content? With error states? Are these designed or generated?
8. **Accessibility from a UX angle.** Are interactive elements obvious? Do focus states exist? Can the page be operated with a keyboard?

## Output

```
## Critique: [target]

### Hierarchy
- [observation, severity]

### Clarity
- [observation, severity]

### Cognitive load
- [score: low/medium/high] — [reasoning]

### Candidates for removal
- [element, reason]

### Missing states
- [empty / loading / error coverage]

### One thing to change first
- [single highest-leverage fix]
```

End with the single highest-leverage change. Do not list ten things if only one matters.
