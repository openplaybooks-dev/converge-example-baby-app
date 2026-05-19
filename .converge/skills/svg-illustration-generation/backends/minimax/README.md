# MiniMax backend

Calls a MiniMax-hosted text-to-image endpoint and writes the result as SVG (or PNG fallback) plus a `.meta.json` sidecar.

## Environment variables

| Variable | Required | Default | Notes |
| --- | --- | --- | --- |
| `MINIMAX_API_KEY` | yes | — | Bearer token; same key used by the LLM provider in `.converge/project.yml`. |
| `MINIMAX_IMAGE_ENDPOINT` | yes | — | Full URL of the image generation endpoint. |
| `MINIMAX_IMAGE_MODEL` | no | `image-01` | Model id. |

## Request shape (skeleton — confirm against live API docs)

The body posted to `MINIMAX_IMAGE_ENDPOINT` currently uses these field names. **Verify these names against the final MiniMax image API documentation** before production use; they're educated guesses based on common patterns from peers (OpenAI `images/generations`, Anthropic Vision, Replicate).

```json
{
  "model": "image-01",
  "prompt": "<composed visual description>",
  "aspect_ratio": "200:200",
  "width": 200,
  "height": 200,
  "output_format": "svg",
  "palette": ["#EDE8F7", "#F28B8B", "#8B7ED8"],
  "references": ["data:image/png;base64,..."],
  "n": 1,
  "response_format": "b64"
}
```

## Response shape

The code accepts several known shapes — direct inline SVG, base64-encoded SVG, or base64 raster — by probing these paths in order:

1. `data[0].svg`, `output[0].svg` → write inline.
2. `data[0].b64_json`, `output[0].b64_json`, `result.image` → decode base64; sniff for `<svg`/`<?xml` header; write SVG or fall back to PNG.

If your endpoint emits a different shape (e.g. a presigned URL), extend the probing block in `generate.js`. The contract from the playbook's perspective is unchanged: `<output_path>` is the SVG file, `<output_path>.meta.json` is the sidecar.

## Filling in unknowns

Search this file for `TODO` markers. The two material unknowns:

1. **Request field names** — `aspect_ratio`, `output_format`, `palette`, `references`, `response_format`. MiniMax may name these differently.
2. **Response key path for the generated image.** The probing block guesses common shapes; verify what your endpoint actually returns.

Once verified, delete the `TODO` markers and remove the unused probing branches.
