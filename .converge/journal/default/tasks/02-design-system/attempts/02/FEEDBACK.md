# FEEDBACK.md — Missing Outputs

**Task**: Design System
**Status**: ❌ 3/5 declared output(s) not found on disk

## Outputs

- ✅ `.stitch/system/DESIGN.md`
- ✅ `.stitch/system/META.md`
- ❌ `.stitch/system/single-screen.html`
- ❌ `.stitch/system/multi-state-screen.html`
- ❌ `.stitch/system/celebration-screen.html`

## ❌ Missing: `.stitch/system/single-screen.html`

Files present in `.stitch/system/` (up to 20):

```
DESIGN.md
META.md
```

## ❌ Missing: `.stitch/system/multi-state-screen.html`

Files present in `.stitch/system/` (up to 20):

```
DESIGN.md
META.md
```

## ❌ Missing: `.stitch/system/celebration-screen.html`

Files present in `.stitch/system/` (up to 20):

```
DESIGN.md
META.md
```

## How to fix

Pick ONE of these, based on what you find above:

1. **If the file truly is missing** — create it per TASK.md instructions.
2. **If a sibling file satisfies the same purpose** (e.g. `.ts` variant of a declared `.js` output) — update the outputs list in the source TASK.md to match what actually exists:
   - Edit `.converge/playbooks/default/tasks/02-design-system/TASK.md`
   - Replace the missing output path with the actual filename on disk.
   - Do NOT change the task body — only the frontmatter `outputs:` list.
3. **If the file should exist under a different name** — rename the on-disk file to match the declared output.

After fixing, the verifier will re-check. Every declared output must exist on disk.