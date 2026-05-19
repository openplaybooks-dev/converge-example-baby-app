# Needs: 002-browse-02-design

## Description

Generate constrained HTML design for Browse using Flutter HTML Glossary

## Inputs

- `.stitch/designs/browse/SPEC.md`
- `.stitch/system/DESIGN.md`
- `.stitch/system/META.md`

## Expected Outputs

- `.stitch/designs/browse/META.md`
- `.stitch/designs/browse/design.html`

## Checks

- **design-exists**: design.html exists for browse
- **meta-exists**: META.md exists for browse
- **uses-glossary**: HTML uses Flutter HTML Glossary vocabulary
- **has-data-attributes**: HTML uses data-* attributes for Flutter conversion
