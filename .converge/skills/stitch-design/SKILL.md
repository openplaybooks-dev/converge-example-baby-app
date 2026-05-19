---
name: stitch-design
description: Reference material that supports the stitch-generate skill — design-token mappings between common design system vocabulary and the Flutter HTML Glossary, plus a list of prompt keywords that produce on-brand visuals. Load alongside stitch-generate when you need extended vocabulary.
---

# stitch-design

This skill is a reference companion to `stitch-generate`. It bundles two static documents under `references/`:

- **`references/design-mappings.md`** — mappings between Material 3 / Tailwind / iOS Human Interface vocabulary and the Flutter HTML Glossary classes. Use when translating designer-vocabulary requests into glossary elements.
- **`references/prompt-keywords.md`** — curated list of prompt fragments (style, mood, palette, motion) that the design system was trained on. Use to bias `stitch-generate` toward on-brand output.

## When to use

Bring `stitch-design` in when:
- The screen specification uses non-glossary vocabulary that needs translating.
- Designs are drifting from the Bloom visual identity — pull `prompt-keywords.md` into the prompt as bias terms.

## When not to use

For straightforward glossary-to-Flutter conversion, `stitch-generate` alone is sufficient — don't load this skill unnecessarily.
