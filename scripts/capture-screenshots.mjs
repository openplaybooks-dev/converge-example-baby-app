#!/usr/bin/env node
// Capture full-page screenshots of every go_router route in the generated
// Flutter web build. Drives Chrome via the DevTools Protocol so we can ask
// for the entire scrollable page (not just the visible viewport) — Chrome's
// own `--screenshot` flag only captures the viewport, which clips content
// past the bottom and right edges.
//
// Reuse: run after `flutter build web --release` and `python3 -m http.server 8765`.
//
// Deps: puppeteer-core (uses the system Chrome at $CHROME_PATH or the macOS default;
// puppeteer-core skips the bundled-Chrome download, which can fail on small disks).

import { execSync, spawn } from 'node:child_process';
import { mkdirSync, existsSync } from 'node:fs';
import { setTimeout as sleep } from 'node:timers/promises';

const PORT = process.env.PORT || '8765';
const OUT_DIR = 'docs/screenshots';
const VIEWPORT_W = 430;   // iPhone 16 Pro Max logical width
// We render at a tall viewport (not the 932px true phone height) so scrollable
// Flutter screens — Home's Quick Actions grid, article-reader's full body, the
// pregnancy-progress detail — fit in one shot. The DOM's scrollHeight doesn't
// reflect canvas content past the viewport, so picking a fixed tall height is
// the most reliable approach. Pages shorter than this get whitespace below;
// the README renders inline at width=320, which absorbs it visually.
const VIEWPORT_H = 2400;
const DPR = 2;            // retina

const ROUTES = [
  ['/',                       '01-home'],
  ['/browse',                 '02-browse'],
  ['/library',                '03-library'],
  ['/profile',                '04-profile'],
  ['/cycle-tracking',         '05-cycle-tracking'],
  ['/weight-nutrition',       '06-weight-nutrition'],
  ['/pregnancy-progress',     '07-pregnancy-progress'],
  ['/mindfulness',            '08-mindfulness'],
  ['/health-log',             '09-health-log'],
  ['/mood-wellness',          '10-mood-wellness'],
  ['/education',              '11-education'],
  ['/article-reader/sample',  '12-article-reader'],
  ['/settings',               '13-settings'],
];

mkdirSync(OUT_DIR, { recursive: true });

// Lazy-load puppeteer-core (uses the system Chrome — no bundled-browser download).
let puppeteer;
try {
  puppeteer = (await import('puppeteer-core')).default;
} catch {
  console.log('Installing puppeteer-core (one-time)…');
  execSync('PUPPETEER_SKIP_DOWNLOAD=true npm install --no-save puppeteer-core', { stdio: 'inherit' });
  puppeteer = (await import('puppeteer-core')).default;
}

// Verify the dev server is up.
const url = `http://localhost:${PORT}/`;
try {
  execSync(`curl -fs ${url} > /dev/null`);
} catch {
  console.error(`Cannot reach ${url}. Did you start the static server? Try:`);
  console.error('  (cd build/web && python3 -m http.server 8765)');
  process.exit(1);
}

const CHROME_PATH = process.env.CHROME_PATH
  || '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';

const browser = await puppeteer.launch({
  executablePath: CHROME_PATH,
  headless: true,
  defaultViewport: { width: VIEWPORT_W, height: VIEWPORT_H, deviceScaleFactor: DPR },
});

const page = await browser.newPage();
// Flutter web takes a few seconds to bootstrap on first load; navigate once
// to warm it up before walking routes.
console.log('Warming up Flutter…');
await page.goto(`http://localhost:${PORT}/`, { waitUntil: 'networkidle0', timeout: 60000 });
await sleep(3000);

for (const [route, name] of ROUTES) {
  const fullUrl = `http://localhost:${PORT}/#${route}`;
  console.log(`  ${name}  ←  ${fullUrl}`);
  await page.goto(fullUrl, { waitUntil: 'networkidle0', timeout: 60000 });
  await sleep(2500);

  await page.screenshot({ path: `${OUT_DIR}/${name}.png`, type: 'png' });
}

await browser.close();
console.log('\nDone. PNGs in', OUT_DIR);
