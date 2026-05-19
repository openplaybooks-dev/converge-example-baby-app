---
id: 006-weight-nutrition-06-lift
title: "Lift: Weight & Nutrition"
description: Lift shared widgets from Weight & Nutrition to lib/widgets/
blocking: true
inputs:
  - .stitch/designs/weight-nutrition/widgets.jsonl
  - lib/screens/weight_nutrition/_widgets/**/*.dart
outputs:
  - lib/widgets/**/*.dart
seed:
  mode: cli
tags:
  - lift
  - screen-weight-nutrition
vars:
  screenId: weight-nutrition
  title: Weight & Nutrition
  screenPath: lib/screens/weight_nutrition/weight_nutrition_screen.dart
  widgetsJsonPath: .stitch/designs/weight-nutrition/widgets.jsonl
  localWidgetsDir: lib/screens/weight_nutrition/_widgets
---

# Lift: Weight & Nutrition

Lift each widget in `lib/screens/weight_nutrition/_widgets/` marked `shared: true` in `.stitch/designs/weight-nutrition/widgets.jsonl` to `lib/widgets/` — one spawn per shared widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/weight-nutrition/widgets.jsonl"
LOCAL_DIR="lib/screens/weight_nutrition/_widgets"
SCREEN_PATH="lib/screens/weight_nutrition/weight_nutrition_screen.dart"
SID="weight-nutrition"
TITLE="Weight & Nutrition"

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
