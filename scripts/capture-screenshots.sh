#!/usr/bin/env bash
# Capture one PNG per top-level route by building Flutter web, serving it locally,
# and using headless Chrome to screenshot each go_router URL hash route.
#
# Why web (not iOS simulator)? On most macOS dev machines, Xcode's iOS Simulator
# SDK version frequently lags the installed Xcode (e.g. Xcode 26 ships expecting
# iOS 26.x runtime, but only iOS 18.x is installed) and `flutter run -d ios` will
# fail to find a matching destination. Web is reliable, deterministic, and the
# Flutter rendering pipeline is the same across platforms — the screenshots fairly
# represent what users see.
#
# Reuse: rerun after any rebuild of `lib/` to refresh `docs/screenshots/`.

set -euo pipefail

OUT_DIR="docs/screenshots"
PORT="${PORT:-8765}"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
WIDTH="${WIDTH:-390}"
HEIGHT="${HEIGHT:-844}"
BUDGET_MS="${BUDGET_MS:-12000}"

ROUTES=(
  "/"                       "01-home"
  "/browse"                 "02-browse"
  "/library"                "03-library"
  "/profile"                "04-profile"
  "/cycle-tracking"         "05-cycle-tracking"
  "/weight-nutrition"       "06-weight-nutrition"
  "/pregnancy-progress"     "07-pregnancy-progress"
  "/mindfulness"            "08-mindfulness"
  "/health-log"             "09-health-log"
  "/mood-wellness"          "10-mood-wellness"
  "/education"              "11-education"
  "/article-reader/sample"  "12-article-reader"
  "/settings"               "13-settings"
)

mkdir -p "$OUT_DIR"

if [ ! -d build/web ]; then
  echo "Building Flutter web (release) …"
  flutter build web --release
fi

# Start a static server in the background. The trap kills it on exit.
(cd build/web && python3 -m http.server "$PORT" > /tmp/baby-app-web.log 2>&1) &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT

# Wait for the server to respond.
for _ in $(seq 1 20); do
  if curl -fs "http://localhost:$PORT/" > /dev/null; then break; fi
  sleep 0.5
done

echo "Capturing ${#ROUTES[@]} screenshots from http://localhost:$PORT/ …"
for ((i = 0; i < ${#ROUTES[@]}; i += 2)); do
  route="${ROUTES[i]}"
  name="${ROUTES[i+1]}"
  url="http://localhost:$PORT/#${route}"
  echo "  $name  ←  $url"
  "$CHROME" --headless --disable-gpu --hide-scrollbars --no-sandbox \
    --window-size="$WIDTH,$HEIGHT" \
    --virtual-time-budget="$BUDGET_MS" \
    --screenshot="$OUT_DIR/$name.png" \
    "$url" 2>/dev/null || echo "    (chrome exited non-zero, file may still be valid)"
done

echo ""
echo "Done. Files in $OUT_DIR/:"
ls -la "$OUT_DIR"/*.png
