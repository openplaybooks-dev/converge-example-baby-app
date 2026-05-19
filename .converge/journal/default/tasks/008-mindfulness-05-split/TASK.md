---
id: 008-mindfulness-05-split
title: "Split: Mindfulness"
description: Extract widgets from Mindfulness screen into local widgets/
inputs:
  - .stitch/designs/mindfulness/widgets.jsonl
outputs:
  - lib/screens/mindfulness/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-mindfulness
vars:
  screenId: mindfulness
  title: Mindfulness
  screenPath: lib/screens/mindfulness/mindfulness_screen.dart
  widgetsJsonPath: .stitch/designs/mindfulness/widgets.jsonl
  localWidgetsDir: lib/screens/mindfulness/_widgets
---

# Split: Mindfulness

Extract each widget identified in `.stitch/designs/mindfulness/widgets.jsonl` into its own file under `lib/screens/mindfulness/_widgets/` — one spawn per widget.

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
