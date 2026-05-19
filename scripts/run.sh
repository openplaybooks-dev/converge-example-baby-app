#!/usr/bin/env bash
# run.sh — execute the baby-app playbook end-to-end.
#
# Usage:
#   ./scripts/run.sh                  # standard run
#   ./scripts/run.sh --dry            # show resolved DAG, don't execute
#   ./scripts/run.sh --resume         # continue from journal after a failure
#   IMAGE_BACKEND=stub ./scripts/run.sh   # cheap smoke test (no image API)
#
# Required env:
#   MINIMAX_API_KEY — auth for both the MiniMax LLM provider and the image API
# Optional env:
#   MINIMAX_IMAGE_ENDPOINT — full URL of the MiniMax image generate endpoint
#                            (only required when IMAGE_BACKEND=minimax, the default)
#   MINIMAX_IMAGE_MODEL    — defaults to "image-01"
#   IMAGE_BACKEND          — overrides .converge/skills/svg-illustration-generation/backends/ACTIVE
#   CONVERGE_BIN           — path to the converge CLI entry (defaults to "converge" on PATH)

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

: "${MINIMAX_API_KEY:?MINIMAX_API_KEY must be exported (used by .converge/project.yml + image backend)}"
export IMAGE_BACKEND="${IMAGE_BACKEND:-minimax}"

if [ "$IMAGE_BACKEND" = "minimax" ] && [ -z "${MINIMAX_IMAGE_ENDPOINT:-}" ]; then
  echo "warning: MINIMAX_IMAGE_ENDPOINT is not set — minimax backend will fail at task 08." >&2
  echo "        set IMAGE_BACKEND=stub for a free smoke test." >&2
fi

CONVERGE_BIN="${CONVERGE_BIN:-converge}"
if ! command -v "$CONVERGE_BIN" >/dev/null 2>&1 && [ ! -f "$CONVERGE_BIN" ]; then
  echo "✗ converge CLI not found (set CONVERGE_BIN to override)" >&2
  exit 1
fi

FLAGS=()
for a in "$@"; do
  case "$a" in
    --dry)    FLAGS+=("--dry") ;;
    --resume) FLAGS+=("--resume") ;;
    *)        FLAGS+=("$a") ;;
  esac
done

echo "── baby-app: run ──"
echo "  backend: $IMAGE_BACKEND"
echo

"$CONVERGE_BIN" run "${FLAGS[@]}" --max-iterations 250

STATUS=$?

echo
echo "── summary ──"
if [ -d lib/screens ]; then
  echo "  screens:       $(find lib/screens -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')"
fi
echo "  illustrations: $(find assets/illustrations -name '*.svg' 2>/dev/null | wc -l | tr -d ' ')"
echo "  icons:         $(find assets/icons -name '*.svg' 2>/dev/null | wc -l | tr -d ' ')"
echo "  tests:         $(find test -name '*_test.dart' 2>/dev/null | wc -l | tr -d ' ')"

if [ "$STATUS" -eq 0 ] && command -v flutter >/dev/null 2>&1; then
  echo
  echo "── final buildability check ──"
  if flutter build apk --debug 2>&1 | tail -5; then
    echo "  ✓ flutter build apk --debug"
  else
    echo "  ✗ flutter build apk --debug (see output above)" >&2
    exit 1
  fi
fi

exit "$STATUS"
