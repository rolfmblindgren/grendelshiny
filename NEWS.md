# grendelshiny 0.2.1

## Bug fix

- `.hero-mark` now centres its content and scales `<img>`/`<svg>` children to
  fit (`object-fit: contain`) instead of clipping them. Previously a logo
  image taller/wider than the fixed 42×42 box was cut off by
  `overflow: hidden`.

# grendelshiny 0.2.0

## Visual redesign

- New light colour palette: airy turquoise-and-emerald theme replacing the
  previous dark background.
- Backgrounds are now light (`#f0fdfb` → `#f0fdf4`) with frosted glass cards.
- Accent colours updated to teal-600 (`#0d9488`) and emerald-500 (`#10b981`).
- Buttons now use a teal → emerald gradient with white text.
- Form controls use a near-white background with a subtle teal border.
- All hardcoded colour values updated; `--text` is now dark (`#0d2420`) for
  legibility on light surfaces.

# grendelshiny 0.1.0

## First release

- `grendelshiny_css()` — includes the shared turquoise-dark base stylesheet.
- `grendelshiny_js()` — includes the shared JavaScript utility for selectize
  dropdown state management.
- Design system covers: hero layout, cards, typography, buttons, form controls,
  sliders, tabs, wells, and responsive breakpoints.
