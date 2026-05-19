---
id: 010-mood-wellness-05-split
title: "Split: Mood & Wellness"
description: Extract widgets from Mood & Wellness screen into local widgets/
inputs:
  - .stitch/designs/mood-wellness/widgets.jsonl
outputs:
  - lib/screens/mood_wellness/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-mood-wellness
vars:
  screenId: mood-wellness
  title: Mood & Wellness
  screenPath: lib/screens/mood_wellness/mood_wellness_screen.dart
  widgetsJsonPath: .stitch/designs/mood-wellness/widgets.jsonl
  localWidgetsDir: lib/screens/mood_wellness/_widgets
---

# Split: Mood & Wellness

Extract each widget identified in `.stitch/designs/mood-wellness/widgets.jsonl` into its own file under `lib/screens/mood_wellness/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/mood-wellness/widgets.jsonl"
LOCAL_DIR="lib/screens/mood_wellness/_widgets"
SCREEN_PATH="lib/screens/mood_wellness/mood_wellness_screen.dart"
SID="mood-wellness"
TITLE="Mood & Wellness"

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
