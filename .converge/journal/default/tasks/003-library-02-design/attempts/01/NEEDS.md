# Needs: 003-library-02-design

## Description

Generate constrained HTML design for Library using Flutter HTML Glossary

## Inputs

- `.stitch/designs/library/SPEC.md`
- `.stitch/system/DESIGN.md`
- `.stitch/system/META.md`

## Expected Outputs

- `.stitch/designs/library/META.md`
- `.stitch/designs/library/design.html`

## Checks

- **design-exists**: design.html exists for library
- **meta-exists**: META.md exists for library
- **uses-glossary**: HTML uses Flutter HTML Glossary vocabulary
- **has-data-attributes**: HTML uses data-* attributes for Flutter conversion
