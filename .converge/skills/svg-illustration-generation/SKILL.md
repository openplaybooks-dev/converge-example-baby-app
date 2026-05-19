---
name: svg-illustration-generation
description: Generate a single SVG asset for a Flutter slot via a swappable image backend. Reads a composed prompt + style spec, dispatches to backends/<ACTIVE>/generate.js, writes the file + a .meta.json sidecar. MiniMax backend is primary; stub returns a placeholder SVG for CI.
---

# svg-illustration-generation

Adapter over a text-to-image API that writes Flutter-ready SVG assets. The skill dispatches to a backend selected by `.converge/skills/svg-illustration-generation/backends/ACTIVE` (a single line, e.g. `minimax`), overridable per-process by the `IMAGE_BACKEND` env var.

## Contract

### Input (JSON on stdin)

```ts
{
  prompt: string,                            // composed visual description
  output_path: string,                       // e.g. "assets/illustrations/baby-sizes/week-12.svg"
  dimensions: { width: number, height: number },
  asset_type: "illustration" | "icon" | "empty-state",
  palette?: string[],                        // optional hex codes from DESIGN.md
  references?: string[]                      // 0-3 reference asset paths
}
```

### Output

The backend MUST:
1. Write the SVG (or PNG fallback) to `output_path`.
2. Write a sidecar `<output_path>.meta.json` with:
   ```json
   { "backend": "minimax|stub", "seed": <int|null>, "model": "<string>", "bytes": <int>, "mime": "image/svg+xml" }
   ```
3. Exit zero on success; on failure, write the upstream error to stderr and exit non-zero.

## Procedure

1. Resolve the active backend (`IMAGE_BACKEND` env var wins; otherwise read `backends/ACTIVE`).
2. Dynamic-import `backends/<name>/generate.js` and call its default export with the parsed input.
3. The backend handles its own auth (`MINIMAX_API_KEY`, `MINIMAX_IMAGE_ENDPOINT` etc.) and writes both files.

## Backends

- **`minimax/`** — production primary. Calls a MiniMax-hosted text-to-image endpoint. Requires `MINIMAX_API_KEY` and `MINIMAX_IMAGE_ENDPOINT` (and optionally `MINIMAX_IMAGE_MODEL`). The skeleton in `backends/minimax/generate.js` documents the expected request/response shape — fill in the final field names once you have the endpoint docs.
- **`stub/`** — writes a 1-line valid SVG placeholder. No network. Suitable for CI and local smoke tests (`IMAGE_BACKEND=stub`).

## Environment

- `MINIMAX_API_KEY` — required when backend is `minimax`
- `MINIMAX_IMAGE_ENDPOINT` — required when backend is `minimax` (e.g. `https://api.minimax.io/v1/image/generate`)
- `MINIMAX_IMAGE_MODEL` — optional (defaults to `image-01`)
- `IMAGE_BACKEND` — overrides `ACTIVE` at runtime

## Quality rules

- Output must be valid SVG 1.1+ (icons) or SVG 2.0 (illustrations).
- No external resources (no remote fonts, no `<image href="http://...">`).
- File size 100 B–500 KB.
- For icons: single fill colour, 1.5px stroke, 24×24 viewBox.
- For illustrations: soft pastel palette consistent with `.stitch/system/DESIGN.md`.
