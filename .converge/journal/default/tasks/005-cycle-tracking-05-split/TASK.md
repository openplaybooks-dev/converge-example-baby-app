---
id: 005-cycle-tracking-05-split
title: "Split: Cycle Tracking"
description: Extract widgets from Cycle Tracking screen into local widgets/
inputs:
  - .stitch/designs/cycle-tracking/widgets.jsonl
outputs:
  - lib/screens/cycle_tracking/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-cycle-tracking
vars:
  screenId: cycle-tracking
  title: Cycle Tracking
  screenPath: lib/screens/cycle_tracking/cycle_tracking_screen.dart
  widgetsJsonPath: .stitch/designs/cycle-tracking/widgets.jsonl
  localWidgetsDir: lib/screens/cycle_tracking/_widgets
---

# Split: Cycle Tracking

Extract each widget identified in `.stitch/designs/cycle-tracking/widgets.jsonl` into its own file under `lib/screens/cycle_tracking/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/cycle-tracking/widgets.jsonl"
LOCAL_DIR="lib/screens/cycle_tracking/_widgets"
SCREEN_PATH="lib/screens/cycle_tracking/cycle_tracking_screen.dart"
SID="cycle-tracking"
TITLE="Cycle Tracking"

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
