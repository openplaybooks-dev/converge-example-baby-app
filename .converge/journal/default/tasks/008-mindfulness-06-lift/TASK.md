---
id: 008-mindfulness-06-lift
title: "Lift: Mindfulness"
description: Lift shared widgets from Mindfulness to lib/widgets/
blocking: true
inputs:
  - .stitch/designs/mindfulness/widgets.jsonl
  - lib/screens/mindfulness/_widgets/**/*.dart
outputs:
  - lib/widgets/**/*.dart
seed:
  mode: cli
tags:
  - lift
  - screen-mindfulness
vars:
  screenId: mindfulness
  title: Mindfulness
  screenPath: lib/screens/mindfulness/mindfulness_screen.dart
  widgetsJsonPath: .stitch/designs/mindfulness/widgets.jsonl
  localWidgetsDir: lib/screens/mindfulness/_widgets
---

# Lift: Mindfulness

Lift each widget in `lib/screens/mindfulness/_widgets/` marked `shared: true` in `.stitch/designs/mindfulness/widgets.jsonl` to `lib/widgets/` — one spawn per shared widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/mindfulness/widgets.jsonl"
LOCAL_DIR="lib/screens/mindfulness/_widgets"
SCREEN_PATH="lib/screens/mindfulness/mindfulness_screen.dart"
SID="mindfulness"
TITLE="Mindfulness"

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
