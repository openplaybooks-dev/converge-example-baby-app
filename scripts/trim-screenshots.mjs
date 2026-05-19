#!/usr/bin/env node
// Trim trailing whitespace from the screenshots in docs/screenshots/ in-place.
//
// Why this exists: the capture script renders Flutter web at a tall viewport
// (430×2400) so scrollable screens fit in one shot. Pages shorter than the
// viewport leave large empty whitespace at the bottom; some screens also have
// a sticky bottom navigation bar that sits at viewport-end with empty surface
// between it and the body content.
//
// We:
//   1. detect the modal mid-column color and treat that as page-surface
//      background (more reliable than sampling a single corner pixel — works
//      regardless of AppBar color or bottom-nav color)
//   2. classify each row as "content" or "background"
//   3. trim trailing background, OR if there's a large gap between two content
//      regions (body + sticky bottom nav), stitch them together with a small
//      padding band so the screenshot reads naturally on a phone-shaped canvas.
//
// Idempotent: rerunning on already-trimmed PNGs is safe (it just trims further
// trailing bg, of which there will be little after the first pass).
//
// Usage: node scripts/trim-screenshots.mjs [path1.png path2.png ...]
//        (no args → trims every docs/screenshots/*.png)

import sharp from 'sharp';
import { readdirSync, statSync, readFileSync } from 'node:fs';
import { join } from 'node:path';

const TOLERANCE = 8;       // RGB distance under which we treat as same color
const MIN_CONTENT_RUN = 0.04;  // min fraction of row width that must be non-bg
const GAP_THRESHOLD_PX = 80;   // empty-row gap above this triggers nav stitch
const PADDING_BELOW_PX = 24;   // padding under last content row
const GAP_BAND_PX = 24;        // padding band when stitching body + nav

function modalMidColumnColor(raw, width, height, channels) {
  const counts = new Map();
  const midX = Math.floor(width / 2);
  for (let y = 0; y < height; y++) {
    const o = (y * width + midX) * channels;
    const key = (raw[o] << 16) | (raw[o + 1] << 8) | raw[o + 2];
    counts.set(key, (counts.get(key) || 0) + 1);
  }
  let modal = 0, best = -1;
  for (const [k, n] of counts) if (n > best) { best = n; modal = k; }
  return [(modal >> 16) & 0xff, (modal >> 8) & 0xff, modal & 0xff];
}

function classifyRows(raw, width, height, channels, bg) {
  const minContent = Math.max(10, Math.floor(width * MIN_CONTENT_RUN));
  const isContent = new Uint8Array(height);
  for (let y = 0; y < height; y++) {
    let nonBg = 0;
    for (let x = 0; x < width; x++) {
      const o = (y * width + x) * channels;
      if (Math.abs(raw[o] - bg[0]) > TOLERANCE
        || Math.abs(raw[o + 1] - bg[1]) > TOLERANCE
        || Math.abs(raw[o + 2] - bg[2]) > TOLERANCE) {
        if (++nonBg >= minContent) { isContent[y] = 1; break; }
      }
    }
  }
  return isContent;
}

async function trim(path) {
  const buf = readFileSync(path);
  const { width, height } = await sharp(buf).metadata();
  const raw = await sharp(buf).raw().toBuffer();
  const channels = raw.length / (width * height);

  const bg = modalMidColumnColor(raw, width, height, channels);
  const isContent = classifyRows(raw, width, height, channels, bg);

  // Last content row.
  let lastY = -1;
  for (let y = height - 1; y >= 0; y--) if (isContent[y]) { lastY = y; break; }
  if (lastY < 0) return { path, action: 'no-content' };

  // Find the largest gap (run of background) between two content regions
  // anywhere in [0, lastY].
  let gapStart = -1, gapEnd = -1, gapLen = 0;
  let curStart = -1;
  for (let y = 0; y <= lastY; y++) {
    if (!isContent[y]) {
      if (curStart < 0) curStart = y;
    } else if (curStart >= 0) {
      const len = y - curStart;
      if (len > gapLen) { gapLen = len; gapStart = curStart; gapEnd = y; }
      curStart = -1;
    }
  }

  // Decide: stitch body+nav, or simple trim.
  if (gapLen >= GAP_THRESHOLD_PX && gapStart > 0 && gapEnd <= lastY) {
    const topH = gapStart;
    const bottomH = lastY - gapEnd + 1;
    const finalH = topH + GAP_BAND_PX + bottomH + PADDING_BELOW_PX;
    if (finalH >= height) {
      // nothing gained — fall through to plain trim
    } else {
      const top = await sharp(buf).extract({ left: 0, top: 0, width, height: topH }).toBuffer();
      const bot = await sharp(buf).extract({ left: 0, top: gapEnd, width, height: bottomH }).toBuffer();
      await sharp({
        create: { width, height: finalH, channels: 3, background: { r: bg[0], g: bg[1], b: bg[2] } },
      })
        .composite([
          { input: top, top: 0, left: 0 },
          { input: bot, top: topH + GAP_BAND_PX, left: 0 },
        ])
        .png()
        .toFile(path);
      return { path, action: `stitched ${height} → ${finalH} (body ${topH} + band ${GAP_BAND_PX} + nav ${bottomH})` };
    }
  }

  // Simple trim trailing bg.
  const finalH = Math.min(height, lastY + 1 + PADDING_BELOW_PX);
  if (finalH >= height) return { path, action: `kept (already tight at ${height})` };
  await sharp(buf).extract({ left: 0, top: 0, width, height: finalH }).png().toFile(path);
  return { path, action: `trimmed ${height} → ${finalH}` };
}

const args = process.argv.slice(2);
const files = args.length
  ? args
  : readdirSync('docs/screenshots')
      .filter(f => f.endsWith('.png'))
      .map(f => join('docs/screenshots', f));

for (const f of files) {
  if (!statSync(f).isFile()) continue;
  const r = await trim(f);
  console.log(`${r.path}: ${r.action}`);
}
