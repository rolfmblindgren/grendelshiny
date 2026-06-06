#' Include the shared Grendel CSS theme
#'
#' Inserts the shared turquoise-dark base stylesheet into the Shiny UI.
#' Call this before any app-specific CSS so local stylesheets can override
#' individual rules.
#'
#' @return An \code{htmltools} tag object (invisibly).
#' @export
grendelshiny_css <- function() {
  htmltools::includeCSS(system.file("www/custom.css", package = "grendelshiny"))
}

#' Include the shared Grendel JavaScript helpers
#'
#' Inserts the shared JavaScript utility into the Shiny UI.  The script
#' manages selectize dropdown state so that buttons are not accidentally
#' activated while a dropdown menu is open.
#'
#' @return An \code{htmltools} tag object (invisibly).
#' @export
grendelshiny_js <- function() {
  htmltools::includeScript(system.file("www/custom.js", package = "grendelshiny"))
}

# Local Variables:
# mode: R
# End:
