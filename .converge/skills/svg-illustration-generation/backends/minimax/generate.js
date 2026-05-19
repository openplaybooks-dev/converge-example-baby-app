// MiniMax backend — production primary.
//
// Calls a MiniMax text-to-image endpoint. The exact request/response shape
// depends on the endpoint the project owner has access to; the constants and
// `payload` object below are skeletons — confirm field names against the live
// MiniMax image API docs before relying on this in production.
//
// Required env:
//   MINIMAX_API_KEY        — bearer token
//   MINIMAX_IMAGE_ENDPOINT — full URL of the generate endpoint
// Optional env:
//   MINIMAX_IMAGE_MODEL    — model id (default "image-01")

import { writeFile, mkdir, readFile } from 'node:fs/promises';
import { dirname } from 'node:path';

const ENDPOINT = process.env.MINIMAX_IMAGE_ENDPOINT;
const API_KEY = process.env.MINIMAX_API_KEY;
const MODEL = process.env.MINIMAX_IMAGE_MODEL || 'image-01';

export default async function generate(input) {
  const { prompt, output_path, dimensions, asset_type, palette = [], references = [] } = input;
  if (!ENDPOINT) throw new Error('minimax backend: MINIMAX_IMAGE_ENDPOINT is not set');
  if (!API_KEY) throw new Error('minimax backend: MINIMAX_API_KEY is not set');
  if (!output_path) throw new Error('minimax backend: output_path is required');

  const w = dimensions?.width ?? 256;
  const h = dimensions?.height ?? 256;

  // Encode references as base64 data URLs (max 3, common API limit).
  const refDataUrls = [];
  for (const refPath of references.slice(0, 3)) {
    try {
      const bytes = await readFile(refPath);
      const mime = refPath.endsWith('.svg') ? 'image/svg+xml' : 'image/png';
      refDataUrls.push(`data:${mime};base64,${bytes.toString('base64')}`);
    } catch {
      // Reference missing — skip silently; the prompt should still carry the intent.
    }
  }

  // TODO: confirm field names against the final MiniMax image API docs.
  const payload = {
    model: MODEL,
    prompt,
    aspect_ratio: `${w}:${h}`,
    width: w,
    height: h,
    output_format: 'svg',
    palette,
    references: refDataUrls,
    n: 1,
    response_format: 'b64',
  };

  const res = await fetch(ENDPOINT, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  });

  if (!res.ok) {
    const text = await res.text().catch(() => '');
    throw new Error(`minimax image api ${res.status}: ${text || res.statusText}`);
  }

  // TODO: confirm response field name (`data[0].b64_json`? `output[0].svg`? `result.image`?).
  const json = await res.json();
  const b64 =
    json?.data?.[0]?.b64_json ??
    json?.output?.[0]?.b64_json ??
    json?.result?.image ??
    null;
  const directSvg = json?.data?.[0]?.svg ?? json?.output?.[0]?.svg ?? null;
  const seed = json?.data?.[0]?.seed ?? json?.seed ?? null;

  await mkdir(dirname(output_path), { recursive: true });

  let bytesLen = 0;
  let mime = 'image/svg+xml';
  if (directSvg && typeof directSvg === 'string' && directSvg.includes('<svg')) {
    await writeFile(output_path, directSvg, 'utf8');
    bytesLen = Buffer.byteLength(directSvg, 'utf8');
  } else if (b64) {
    const buf = Buffer.from(b64, 'base64');
    // Sniff: if it starts with `<svg` it's an inline SVG string, otherwise raster.
    const head = buf.slice(0, 5).toString('utf8');
    if (head.startsWith('<svg') || head.startsWith('<?xml')) {
      await writeFile(output_path, buf);
      mime = 'image/svg+xml';
    } else {
      // Raster fallback — change extension to .png if caller asked for svg
      const rasterPath = output_path.replace(/\.svg$/, '.png');
      await writeFile(rasterPath, buf);
      mime = 'image/png';
      // Still write a stub .svg pointing at the PNG so wire step finds the expected path.
      const wrapper = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${w} ${h}"><image href="${rasterPath.split('/').pop()}" width="${w}" height="${h}"/></svg>\n`;
      await writeFile(output_path, wrapper, 'utf8');
    }
    bytesLen = buf.length;
  } else {
    throw new Error(`minimax image api: unrecognised response shape — got keys ${Object.keys(json || {}).join(',')}`);
  }

  const meta = { backend: 'minimax', seed, model: MODEL, bytes: bytesLen, mime };
  await writeFile(`${output_path}.meta.json`, JSON.stringify(meta, null, 2), 'utf8');

  return { file_path: output_path, meta };
}
