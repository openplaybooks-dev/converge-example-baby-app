---
title: "Lift widget: {{widgetName}}"
description: "Move {{widgetName}} from per-screen _widgets/ to shared lib/widgets/"
tags:
  - lift
  - widget
vars:
  screenId:
  screenTitle:
  screenPath:
  widgetId:
  widgetName:
  localFile:
  sharedFile:
inputs:
  - "{{localFile}}"
outputs:
  - "{{sharedFile}}"
checks:
  - id: shared-exists
    cmd: "test -f {{sharedFile}}"
    description: "Shared widget file exists"
  - id: dart-valid
    cmd: "dart analyze {{sharedFile}}"
    description: "Dart analysis passes"
---

# Lift widget: {{widgetName}}

Move the `{{widgetName}}` widget from `{{localFile}}` to `{{sharedFile}}` and update every importer.

## Steps

1. **Move** — Copy `{{localFile}}` → `{{sharedFile}}`. Delete the original after step 4 succeeds.
2. **Update import path** — In the new file, change any relative imports of sibling per-screen widgets to package paths if those siblings have also been lifted. Otherwise leave as relative imports.
3. **Update referrers** — `grep -RnE "import '.*{{localFile}}'" lib/` (or the equivalent relative-path pattern) and rewrite each match to `import 'package:folio/widgets/{{widgetName}}.dart';` (camelCase widget name → snake_case file name handled by the existing convention).
4. **Verify** — `dart analyze lib/` must remain green; any orphan import after the rename should be removed.

## Rules

- Don't lift widgets that aren't marked `shared: true` in the widgets manifest — that's the parent's job to filter.
- Preserve all semantics labels.
- After verification passes, remove the original `{{localFile}}` so we don't have two copies.
