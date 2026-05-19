// stub backend — writes a valid 1-shape SVG placeholder.
// Used for CI and `IMAGE_BACKEND=stub` smoke tests so the playbook can converge
// end-to-end without hitting a real image API.

import { writeFile, mkdir } from 'node:fs/promises';
import { dirname } from 'node:path';

export default async function generate(input) {
  const { prompt, output_path, dimensions, asset_type } = input;
  if (!output_path) throw new Error('stub backend: output_path is required');
  const w = dimensions?.width ?? 200;
  const h = dimensions?.height ?? 200;

  const fill = asset_type === 'icon' ? '#2A2A3A' : '#EDE8F7';
  const stroke = asset_type === 'icon' ? '#2A2A3A' : '#8B7ED8';
  const label = (prompt ?? asset_type ?? 'stub').slice(0, 40).replace(/[<>&]/g, '');

  const svg =
    `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${w} ${h}" width="${w}" height="${h}">` +
    `<rect x="1" y="1" width="${w - 2}" height="${h - 2}" rx="${Math.min(w, h) * 0.08}" ` +
    `fill="${fill}" stroke="${stroke}" stroke-width="1.5"/>` +
    `<text x="50%" y="50%" font-family="sans-serif" font-size="${Math.max(8, Math.min(w, h) * 0.08)}" ` +
    `text-anchor="middle" dominant-baseline="middle" fill="${stroke}">stub: ${label}</text>` +
    `</svg>\n`;

  await mkdir(dirname(output_path), { recursive: true });
  await writeFile(output_path, svg, 'utf8');

  const meta = {
    backend: 'stub',
    seed: null,
    model: 'stub@1',
    bytes: Buffer.byteLength(svg, 'utf8'),
    mime: 'image/svg+xml',
  };
  await writeFile(`${output_path}.meta.json`, JSON.stringify(meta, null, 2), 'utf8');

  return { file_path: output_path, meta };
}
