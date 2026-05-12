grendelshiny_css <- function() {
  htmltools::includeCSS(system.file("www/custom.css", package = "grendelshiny"))
}

grendelshiny_js <- function() {
  htmltools::includeScript(system.file("www/custom.js", package = "grendelshiny"))
}

# Local Variables:
# mode: R
# End:
