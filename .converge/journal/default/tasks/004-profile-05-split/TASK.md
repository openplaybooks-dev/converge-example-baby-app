---
id: 004-profile-05-split
title: "Split: Profile"
description: Extract widgets from Profile screen into local widgets/
inputs:
  - .stitch/designs/profile/widgets.jsonl
outputs:
  - lib/screens/profile/_widgets/**/*.dart
seed:
  mode: cli
tags:
  - split
  - screen-profile
vars:
  screenId: profile
  title: Profile
  screenPath: lib/screens/profile/profile_screen.dart
  widgetsJsonPath: .stitch/designs/profile/widgets.jsonl
  localWidgetsDir: lib/screens/profile/_widgets
---

# Split: Profile

Extract each widget identified in `.stitch/designs/profile/widgets.jsonl` into its own file under `lib/screens/profile/_widgets/` — one spawn per widget.

```bash
TEMPLATES=".converge/playbooks/default/templates"
WIDGETS=".stitch/designs/profile/widgets.jsonl"
LOCAL_DIR="lib/screens/profile/_widgets"
SCREEN_PATH="lib/screens/profile/profile_screen.dart"
SID="profile"
TITLE="Profile"

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
