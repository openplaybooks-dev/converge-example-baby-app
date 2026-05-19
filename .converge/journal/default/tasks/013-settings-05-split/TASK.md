---
id: 013-settings-05-split
title: "Split: Settings"
description: Extract widgets from Settings screen into local widgets/
inputs:
  - .stitch/designs/settings/widgets.jsonl
outputs:
  - lib/screens/settings/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-settings
vars:
  screenId: settings
  title: Settings
  screenPath: lib/screens/settings/settings_screen.dart
  widgetsJsonPath: .stitch/designs/settings/widgets.jsonl
  localWidgetsDir: lib/screens/settings/_widgets
---

# Split: Settings

Extract each widget identified in `.stitch/designs/settings/widgets.jsonl` into its own file under `lib/screens/settings/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/settings/widgets.jsonl"
LOCAL_DIR="lib/screens/settings/_widgets"
SCREEN_PATH="lib/screens/settings/settings_screen.dart"
SID="settings"
TITLE="Settings"

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
