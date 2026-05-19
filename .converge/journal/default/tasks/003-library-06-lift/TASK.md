---
id: 003-library-06-lift
title: "Lift: Library"
description: Lift shared widgets from Library to lib/widgets/
blocking: true
inputs:
  - .stitch/designs/library/widgets.jsonl
  - lib/screens/library/_widgets/**/*.dart
outputs:
  - lib/widgets/**/*.dart
seed:
  mode: cli
tags:
  - lift
  - screen-library
vars:
  screenId: library
  title: Library
  screenPath: lib/screens/library/library_screen.dart
  widgetsJsonPath: .stitch/designs/library/widgets.jsonl
  localWidgetsDir: lib/screens/library/_widgets
---

# Lift: Library

Lift each widget in `lib/screens/library/_widgets/` marked `shared: true` in `.stitch/designs/library/widgets.jsonl` to `lib/widgets/` — one spawn per shared widget.

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
  SHARED=$(echo "${W}" | jq -r '.shared // false')
  [ "${SHARED}" = "true" ] || continue
  I=$((I + 1))
  P=$(printf '%03d' "${I}")
  WID=$(echo "${W}"   | jq -r '.id // .name')
  WNAME=$(echo "${W}" | jq -r '.name // .id')
  LOCAL_FILE="${LOCAL_DIR}/${WNAME}.dart"
  SHARED_FILE="lib/widgets/${WNAME}.dart"
  converge spawn template \
    --path "${TEMPLATES}/screen-widget-lift/TASK.md" \
    --id "${SID}-lift-${P}-${WID}" \
    --var "screenId=${SID}" \
    --var "screenTitle=${TITLE}" \
    --var "screenPath=${SCREEN_PATH}" \
    --var "widgetId=${WID}" \
    --var "widgetName=${WNAME}" \
    --var "localFile=${LOCAL_FILE}" \
    --var "sharedFile=${SHARED_FILE}"
done < "${WIDGETS}"
```

If no widgets are shared (or the file is missing/empty), exit with no spawns.
