---
id: 08-generate-assets
title: Generate Assets — Icons, Illustrations & Empty States
description: Catalog-driven asset pipeline — spec, generate (via swappable image backend), wire — for every entry in the asset catalog
references:
  - flutter-asset-integration
  - svg-illustration-generation
seed:
  mode: cli
blocking: true
depends_on:
  - 07-build-overlays
tags:
  - assets
  - svg
  - illustrations
  - icons
inputs:
  - .stitch/system/DESIGN.md
  - lib/models/*.dart
  - lib/screens/**/*.dart
outputs:
  - assets/illustrations/baby-sizes/**/*.svg
  - assets/illustrations/empty-states/**/*.svg
  - assets/icons/**/*.svg
  - lib/widgets/assets/**/*.dart
checks:
  - id: weeks-generated
    cmd: "[ $(find assets/illustrations/baby-sizes -name '*.svg' 2>/dev/null | wc -l | tr -d ' ') -ge 40 ]"
    description: 40 weekly baby-size illustrations exist
  - id: empty-states-generated
    cmd: "[ $(find assets/illustrations/empty-states -name '*.svg' 2>/dev/null | wc -l | tr -d ' ') -ge 5 ]"
    description: 5 empty-state illustrations exist
  - id: icons-generated
    cmd: "[ $(find assets/icons -name '*.svg' 2>/dev/null | wc -l | tr -d ' ') -ge 15 ]"
    description: 15 icons exist
  - id: dart-analysis-valid
    cmd: dart analyze lib/
    description: All wired asset widgets pass analysis
---

# Generate Assets — Icons, Illustrations & Empty States

Three-step per-asset pipeline (spec, generate, wire) driven by an inline deterministic catalog: 40 pregnancy-week illustrations, 5 empty-state illustrations, 15 feature icons. Total: 60 assets × 3 steps = 180 spawned children.

Each generate step calls the `svg-illustration-generation` skill, whose active backend (`minimax` for production, `stub` for CI) is selected by `.converge/skills/svg-illustration-generation/backends/ACTIVE` or the `IMAGE_BACKEND` env var.

**How to seed this task:**

1. Run the Bash script below with the **Bash** tool. It prints one `converge spawn template …` line per spawn — shell-safe quoting.
2. Copy each printed line into the `commands` array verbatim. There will be 180 lines.

```bash
set -euo pipefail
TEMPLATES=".converge/playbooks/default/templates"

# Baby-size comparisons keyed to pregnancy weeks 1–40.
SIZE_COMPARISONS=(
  "poppy seed" "sesame seed" "lentil" "blueberry" "raspberry" "cherry" "strawberry"
  "lime" "plum" "prune" "fig" "lemon" "apple" "avocado" "onion" "sweet potato"
  "mango" "banana" "pomegranate" "papaya" "carrot" "spaghetti squash" "mango"
  "corn ear" "eggplant" "acorn squash" "cauliflower" "lettuce head" "cabbage"
  "butternut squash" "pineapple" "cantaloupe" "honeydew" "coconut" "winter melon"
  "romaine head" "swiss chard" "leek bunch" "mini watermelon" "small pumpkin"
)

EMPTY_STATES_ID=("empty-data" "empty-search" "empty-history" "error-state" "success-state")
EMPTY_STATES_DESC=(
  "Calm illustration of a journal page with floating leaves — no entries yet"
  "Magnifying glass over a flower — no search results"
  "Open calendar with soft glow — no history available"
  "Cloud with a soft tear-drop — gentle error indicator"
  "Sparkles around a bloom — celebration / success"
)

ICONS_ID=(
  "nav-home" "nav-progress" "nav-health" "nav-mood" "nav-learn"
  "action-add" "action-edit" "action-delete" "action-share" "action-bookmark"
  "status-mood" "status-weight" "status-cycle" "status-symptom" "status-reminder"
)
ICONS_DESC=(
  "Soft house outline" "Upward trend line with a heart" "Heart with pulse line" "Smiling face contour" "Open book"
  "Plus inside a circle" "Pencil with rounded tip" "Trash can with lid" "Arrow leaving a box" "Bookmark ribbon"
  "Three dots arranged as smile" "Scale balance" "Crescent moon" "Spiral wave" "Bell with circle dot"
)

emit() {
  local path="$1" id="$2"; shift 2
  local out="converge spawn template --path $(printf %q "$path") --id $(printf %q "$id")"
  while [ "$#" -gt 0 ]; do
    out="$out --var $(printf %q "$1")"
    shift
  done
  printf '%s\n' "$out"
}

# Emit a 3-step pipeline (spec, generate, wire) for one asset.
emit_pipeline() {
  local prefix="$1" aid="$2" type="$3" output="$4" w="$5" h="$6" desc="$7" widget_name="$8"
  emit "${TEMPLATES}/asset-01-spec/TASK.md" "${prefix}-${aid}-01-spec" \
    "assetId=${aid}" "assetType=${type}" "assetName=${aid}" "assetDescription=${desc}" \
    "outputPath=${output}" "dimensionWidth=${w}" "dimensionHeight=${h}" "format=svg" \
    "specPath=.converge/artifacts/assets/${aid}/SPEC.md"
  emit "${TEMPLATES}/asset-02-generate/TASK.md" "${prefix}-${aid}-02-generate" \
    "assetId=${aid}" "assetType=${type}" "assetName=${aid}" "format=svg" \
    "dimensionWidth=${w}" "dimensionHeight=${h}" "outputPath=${output}" \
    "specPath=.converge/artifacts/assets/${aid}/SPEC.md"
  emit "${TEMPLATES}/asset-03-wire/TASK.md" "${prefix}-${aid}-03-wire" \
    "assetId=${aid}" "assetType=${type}" "assetName=${aid}" "assetDescription=${desc}" \
    "assetWidgetName=${widget_name}" "outputPath=${output}" \
    "dimensionWidth=${w}" "dimensionHeight=${h}"
}

# 1) Weeks 1–40: illustrations, 200x200.
for W in $(seq 1 40); do
  WW=$(printf '%02d' "$W")
  PREFIX=$(printf '%03d' "$W")
  IDX=$((W - 1))
  COMP="${SIZE_COMPARISONS[$IDX]}"
  emit_pipeline "${PREFIX}" "week-${WW}" "illustration" "assets/illustrations/baby-sizes/week-${WW}.svg" "200" "200" \
    "Soft pastel illustration of a ${COMP} — baby size comparison for pregnancy week ${W}" \
    "Week${WW}"
done

# 2) Empty states: 5 illustrations, 240x240.
for I in 0 1 2 3 4; do
  PREFIX=$(printf '%03d' $((41 + I)))
  AID="${EMPTY_STATES_ID[$I]}"
  DESC="${EMPTY_STATES_DESC[$I]}"
  WNAME=$(echo "${AID}" | awk -F'-' '{ s=""; for (i=1;i<=NF;i++){ if (length($i)>0) s = s toupper(substr($i,1,1)) tolower(substr($i,2)) } print s }')
  emit_pipeline "${PREFIX}" "${AID}" "empty-state" "assets/illustrations/empty-states/${AID}.svg" "240" "240" "${DESC}" "${WNAME}"
done

# 3) Icons: 15 outlined stroke icons, 24x24.
for I in $(seq 0 14); do
  PREFIX=$(printf '%03d' $((46 + I)))
  AID="${ICONS_ID[$I]}"
  DESC="${ICONS_DESC[$I]} (24x24 outlined stroke icon, single colour, 1.5px stroke)"
  WNAME=$(echo "${AID}" | awk -F'-' '{ s=""; for (i=1;i<=NF;i++){ if (length($i)>0) s = s toupper(substr($i,1,1)) tolower(substr($i,2)) } print s }')
  emit_pipeline "${PREFIX}" "${AID}" "icon" "assets/icons/${AID}.svg" "24" "24" "${DESC}" "${WNAME}"
done
```
