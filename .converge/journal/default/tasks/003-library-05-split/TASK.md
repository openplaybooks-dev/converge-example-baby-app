---
id: 003-library-05-split
title: "Split: Library"
description: Extract widgets from Library screen into local widgets/
inputs:
  - .stitch/designs/library/widgets.jsonl
outputs:
  - lib/screens/library/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-library
vars:
  screenId: library
  title: Library
  screenPath: lib/screens/library/library_screen.dart
  widgetsJsonPath: .stitch/designs/library/widgets.jsonl
  localWidgetsDir: lib/screens/library/_widgets
---

# Split: Library

Extract each widget identified in `.stitch/designs/library/widgets.jsonl` into its own file under `lib/screens/library/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/library/widgets.jsonl"
LOCAL_DIR="lib/screens/library/_widgets"
SCREEN_PATH="lib/screens/library/library_screen.dart"
SID="library"
TITLE="Library"

[ -f "${WIDGETS}" ] || exit 0

I=0
while IFS= read -r W; do
  [ -z "${W}" ] && continue
  I=$((I + 1))
  P=$(printf '%03d' "${I}")
  WID=$(echo "${W}"      | jq -r '.id // .name')
  WNAME=$(echo "${W}"    | jq -r '.name // .id')
  WIDGET_FILE="${LOCAL_DIR}/${WNAME}.dart"
  converge spawn template \
    --path "${TEMPLATES}/screen-widget-split/TASK.md" \
    --id "${SID}-split-${P}-${WID}" \
    --var "screenId=${SID}" \
    --var "screenTitle=${TITLE}" \
    --var "screenPath=${SCREEN_PATH}" \
    --var "widgetId=${WID}" \
    --var "widgetName=${WNAME}" \
    --var "widgetFile=${WIDGET_FILE}"
done < "${WIDGETS}"
```

If the widgets file is missing or empty, exit with no spawns.
