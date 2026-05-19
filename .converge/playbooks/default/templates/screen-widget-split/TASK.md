---
title: "Split widget: {{widgetName}}"
description: "Extract {{widgetName}} from {{screenTitle}} screen into its own file"
tags:
  - split
  - widget
vars:
  screenId:
  screenTitle:
  screenPath:
  widgetId:
  widgetName:
  widgetFile:
inputs:
  - "{{screenPath}}"
outputs:
  - "{{widgetFile}}"
checks:
  - id: widget-exists
    cmd: "test -f {{widgetFile}}"
    description: "Widget file exists"
  - id: dart-valid
    cmd: "dart analyze {{widgetFile}}"
    description: "Dart analysis passes"
---

# Split widget: {{widgetName}}

Extract the `{{widgetName}}` widget subtree from `{{screenPath}}` into its own file at `{{widgetFile}}`.

## Steps

1. **Read** — Load `{{screenPath}}`.
2. **Locate** — Find the widget subtree implementing `{{widgetName}}`. Use the description in `.stitch/designs/{{screenId}}/widgets.jsonl` (the entry with `name == "{{widgetName}}"`) to disambiguate.
3. **Create file** — Write `{{widgetFile}}` as a self-contained Stateless or Consumer widget, preserving all imports, theme lookups, and Riverpod accesses.
4. **Update screen** — Replace the inline subtree in `{{screenPath}}` with `const {{widgetName}}()` and add the relative import.
5. **Verify** — Run `dart analyze {{widgetFile}} {{screenPath}}` — must pass.

## Rules

- No hardcoded colours; use `Theme.of(context).colorScheme.*`.
- No hardcoded text styles; use `Theme.of(context).textTheme.*`.
- Preserve existing semantics labels and tooltips.
- One `const` constructor per widget.
