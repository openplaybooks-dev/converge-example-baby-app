#!/usr/bin/env bash
# Build Flutter web, serve it locally, and capture one full-page PNG per route.
#
# Why web (not iOS simulator)? Xcode's iOS Simulator SDK version frequently lags
# the installed Xcode (e.g. Xcode 26 expects iOS 26.x runtime; many machines
# only have iOS 18.x). `flutter run -d ios` then fails on the version mismatch
# without manually downloading the runtime via Xcode → Settings → Components.
# Web uses the same widget tree and layout engine; screenshots fairly represent
# the mobile UI.
#
# Why a Node helper for the actual capture? Chrome's `--screenshot` flag only
# captures the viewport (clipping any content below the fold). We use Puppeteer
# + the DevTools Protocol to take `fullPage: true` shots that include scrollable
# content. See `capture-screenshots.mjs`.

set -euo pipefail

PORT="${PORT:-8765}"

if [ ! -d build/web ]; then
  echo "Building Flutter web (release) …"
  flutter build web --release
fi

# Free the port if a stale server is hanging around.
lsof -ti:"$PORT" | xargs kill 2>/dev/null || true

# Start a static server in the background. Trap kills it on exit.
(cd build/web && python3 -m http.server "$PORT" > /tmp/baby-app-web.log 2>&1) &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT

for _ in $(seq 1 20); do
  if curl -fs "http://localhost:$PORT/" > /dev/null; then break; fi
  sleep 0.5
done

node scripts/capture-screenshots.mjs
