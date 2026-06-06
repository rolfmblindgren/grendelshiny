# grendelshiny — instructions for LLM use

This file is the authoritative reference for using grendelshiny in a Shiny app.
Read this before reading any other file in the package.

## What the package does

grendelshiny distributes a shared visual theme and a JavaScript utility to a
family of Grendel Shiny applications.  It provides two functions that inject
a bundled CSS file and a bundled JavaScript file into the Shiny UI.

## Exported functions

### `grendelshiny_css()`

Inserts the shared turquoise-dark base stylesheet into the page.  Takes no
arguments.  Call this **before** any app-specific CSS so that local stylesheets
can override individual rules.

```r
ui <- fluidPage(
  grendelshiny::grendelshiny_css(),   # shared base — first
  shiny::includeCSS("www/custom.css") # app-specific overrides — after
)
```

### `grendelshiny_js()`

Inserts the shared JavaScript utility into the page.  Takes no arguments.
The script manages selectize dropdown state: it prevents button clicks while
a dropdown is open and hides the button with id `"beregn"` during selection.

```r
ui <- fluidPage(
  grendelshiny::grendelshiny_css(),
  grendelshiny::grendelshiny_js()
)
```

Both functions return an `htmltools` tag object and are called for their
side-effects.  Order matters: CSS before JS, shared before app-specific.

## CSS design system

The shared stylesheet (`inst/www/custom.css`) implements a complete design
system.  Use these class names in your UI.

### Color tokens (CSS variables)

| Variable | Value | Use |
|----------|-------|-----|
| `--bg-0` | `#f0fdfb` | Light turquoise background |
| `--bg-1` | `#f8fffd` | Near-white background |
| `--bg-2` | `#f0fdf4` | Light emerald background |
| `--accent` | `#0d9488` | Primary teal (teal-600) |
| `--accent-2` | `#10b981` | Emerald accent (emerald-500) |
| `--text` | `#0d2420` | Dark teal body text |
| `--muted` | `#4d7b74` | Muted secondary text |
| `--border` | `rgba(13,148,136,0.14)` | Subtle borders |
| `--border-strong` | `rgba(13,148,136,0.26)` | Emphasized borders |
| `--surface` | `rgba(255,255,255,0.84)` | Frosted glass card backgrounds |
| `--shadow` | `0 24px 80px rgba(13,148,136,0.10)` | Depth shadow |

### Layout classes

| Class | Purpose |
|-------|---------|
| `.hero` | Two-column grid (1.6fr content + 0.92fr sidebar), max 1240px, stacks below 992px |
| `.hero-copy` | Left content column — frosted glass card, 28px padding |
| `.hero-panel` | Right sidebar column — sticky on desktop, accent-tinted top edge |
| `.hero-header` | Row with 42×42px icon mark left of heading |
| `.hero-badges` | Flex-wrapped pill collection |
| `.hero-badge` | Individual rounded pill |
| `.sidebar-card` | Sticky card, full-width buttons, frosted glass |
| `.main-card` | Non-sticky card, min-height 100%, z-index 1 |
| `.eyebrow` | Uppercase badge label above headings |
| `.well` | Subtle inset container |

### Typography

| Element | Size | Notes |
|---------|------|-------|
| `h1` | `clamp(2.35rem, …, 4.15rem)` | Fluid, -0.05em letter-spacing |
| `h2` | `1.4rem` | -0.03em letter-spacing |
| `h3` | `1.02rem` | |
| `h4` | `0.94rem` | Uppercase, 0.12em letter-spacing |
| `p` | — | 1.65 line-height |
| `.eyebrow` | `0.75rem` | Uppercase, 700 weight, `#96e8db` |

### Form controls

All form controls (`input`, `.form-control`, `.selectize-input`) are
automatically styled — no extra class names needed.

- Minimum height: 46px
- Transparent white background with subtle border
- Focus: accent-colored border + glow shadow
- Buttons (`.action-button`, `.btn-primary`): turquoise gradient, dark text

### Responsive breakpoints

| Breakpoint | Changes |
|------------|---------|
| 992px | Hero → single column; sidebar cards → static |
| 768px | Reduced padding (20px); smaller border-radius; h1 font-size clamped |

## JavaScript utility

The script (`inst/www/custom.js`) exports two global functions:

### `grendelshinySetSelectizeOpen(isOpen)`

Toggles the CSS class `selectize-menu-open` on `document.body` and
controls visibility of the button with id `"beregn"`.

- `isOpen = true` → adds class, hides `#beregn`
- `isOpen = false` → removes class, shows `#beregn`

### `grendelshinyBindSelectizeMenuState()`

Attaches `dropdown_open` / `dropdown_close` event listeners to all
`.selectized` select elements that have not already been bound.  Called
automatically on `DOMContentLoaded`, `shiny:connected`, `shiny:value`,
and on a 200ms polling interval to handle dynamically added elements.

You do not need to call these functions manually.  Including
`grendelshiny_js()` in the UI is enough.

**Note:** The hide/show behaviour targets the button with id `"beregn"`
specifically.  If your app does not have a `#beregn` button, the
selectize state class still works correctly — only the button hiding
part is a no-op.

## Typical UI structure

```r
ui <- shiny::fluidPage(
  grendelshiny::grendelshiny_css(),
  grendelshiny::grendelshiny_js(),
  shiny::includeCSS("www/custom.css"),  # app-specific overrides

  div(class = "hero",
    div(class = "hero-copy",
      div(class = "hero-header",
        div(class = "hero-mark", ...),
        h1("App title")
      ),
      p(class = "eyebrow", "Subtitle"),
      div(class = "hero-badges",
        span(class = "hero-badge", "Tag 1"),
        span(class = "hero-badge", "Tag 2")
      )
    ),
    div(class = "hero-panel",
      div(class = "sidebar-card",
        # inputs, buttons
      )
    )
  )
)
```

## What NOT to do

- Do not call `grendelshiny_js()` before `grendelshiny_css()` — keep CSS first.
- Do not load app-specific CSS before `grendelshiny_css()` — the shared stylesheet
  must come first for overrides to work.
- Do not use CSS variable names directly in inline styles without a fallback —
  some older browsers do not support CSS custom properties.
- Do not call `grendelshinyBindSelectizeMenuState()` or
  `grendelshinySetSelectizeOpen()` manually unless you have a specific reason;
  the script handles binding automatically.
