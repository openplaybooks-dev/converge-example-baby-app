---
id: 007-pregnancy-progress-06-lift
title: "Lift: My Pregnancy"
description: Lift shared widgets from My Pregnancy to lib/widgets/
blocking: true
inputs:
  - .stitch/designs/pregnancy-progress/widgets.jsonl
  - lib/screens/pregnancy_progress/_widgets/**/*.dart
outputs:
  - lib/widgets/**/*.dart
seed:
  mode: cli
tags:
  - lift
  - screen-pregnancy-progress
vars:
  screenId: pregnancy-progress
  title: My Pregnancy
  screenPath: lib/screens/pregnancy_progress/pregnancy_progress_screen.dart
  widgetsJsonPath: .stitch/designs/pregnancy-progress/widgets.jsonl
  localWidgetsDir: lib/screens/pregnancy_progress/_widgets
---

# Lift: My Pregnancy

Lift each widget in `lib/screens/pregnancy_progress/_widgets/` marked `shared: true` in `.stitch/designs/pregnancy-progress/widgets.jsonl` to `lib/widgets/` — one spawn per shared widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/pregnancy-progress/widgets.jsonl"
LOCAL_DIR="lib/screens/pregnancy_progress/_widgets"
SCREEN_PATH="lib/screens/pregnancy_progress/pregnancy_progress_screen.dart"
SID="pregnancy-progress"
TITLE="My Pregnancy"

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
