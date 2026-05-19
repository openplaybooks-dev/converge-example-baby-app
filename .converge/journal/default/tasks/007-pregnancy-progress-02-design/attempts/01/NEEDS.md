# Needs: 007-pregnancy-progress-02-design

## Description

Generate constrained HTML design for My Pregnancy using Flutter HTML Glossary

## Inputs

- `.stitch/designs/pregnancy-progress/SPEC.md`
- `.stitch/system/DESIGN.md`
- `.stitch/system/META.md`

## Expected Outputs

- `.stitch/designs/pregnancy-progress/META.md`
- `.stitch/designs/pregnancy-progress/design.html`

## Checks

- **design-exists**: design.html exists for pregnancy-progress
- **meta-exists**: META.md exists for pregnancy-progress
- **uses-glossary**: HTML uses Flutter HTML Glossary vocabulary
- **has-data-attributes**: HTML uses data-* attributes for Flutter conversion
