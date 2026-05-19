# Task: 007-pregnancy-progress-05-split

# Split: My Pregnancy

Extract each widget identified in `.stitch/designs/pregnancy-progress/widgets.jsonl` into its own file under `lib/screens/pregnancy_progress/_widgets/` — one spawn per widget.

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