---
description: Add a memorable moment, sparingly
argument-hint: [path or "current file"]
---

# /delight

Add one — at most two — memorable moments to an otherwise polished interface. Restraint is the entire point. Delight applied everywhere is noise.

## Target

$ARGUMENTS

## Rules

1. **One delight per surface, maximum.** A landing page gets one moment. A product UI gets at most one delight in the entire app.
2. **Tied to a meaningful action.** First success, completion, milestone — not "page loaded" or "user scrolled."
3. **Skippable.** Never block the user. If the animation is 800ms, the user can still proceed during it.
4. **Cultural awareness.** Confetti reads as celebration in some contexts and as alarm in others. Sound is rarely appropriate by default.

## Candidate moments

| Surface | Worth a delight |
| --- | --- |
| First sign-up complete | Subtle confetti or a satisfying state-change of the success badge |
| First task created / sent / shipped | Brief celebratory micro-interaction tied to the action |
| Empty state | A small custom illustration with personality, not a default empty box |
| 404 page | Often a good place to be more expressive than the rest of the site |
| Hero scroll moment | One scroll-triggered moment per page, max |
| Hover on the primary CTA | Subtle magnetic effect or color shift with character |

## Anti-delights to remove

- Confetti on every form submit
- Bouncing emojis
- Glitch effects on text
- Mouse-trail animations
- Auto-playing sound
- Animated cursors

## Output

```
## Delight added

**Moment:** [where, what]
**Trigger:** [user action]
**Duration:** [ms]
**Skippable:** [how]
**Reduced-motion fallback:** [what happens]
```

Confirm with the user before adding anything they did not specifically ask for.
