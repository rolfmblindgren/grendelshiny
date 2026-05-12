# grendelshiny

Shared styling for Grendel Shiny apps.

This package holds the common visual layer used across the Grendel Shiny apps.
The idea is simple: keep the shared look in one place, then let each app add its
own small local overrides on top.

## What it provides

- a shared turquoise-dark base theme
- common hero, panel, button, tab, slider, and dropdown styling
- a small shared JS helper for selectize menus and button stacking
- helpers for loading the shared assets from `inst/www/custom.css` and `inst/www/custom.js`

## How to use it

Load the shared CSS before any app-specific CSS:

```r
grendelshiny::grendelshiny_css()
grendelshiny::grendelshiny_js()
includeCSS("www/custom.css")
```

If your app uses another local stylesheet, keep `grendelshiny_css()` first so
the local file can override details where needed.

## Where it fits

This package is meant for the small family of Grendel apps that should feel
visually related without copying the same CSS into every repo.

## Local development

The package lives in `~/src/R/grendelshiny` and is used directly from the local
library during development.
