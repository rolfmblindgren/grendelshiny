#' The canonical Grendel "G" mark
#'
#' Returns the shared Grendel logo mark as a self-contained \code{<img>} tag,
#' meant to be dropped into a \code{.hero-mark} container (see
#' \code{grendelshiny_css()}). The PNG is embedded as a base64 data URI, so
#' no \code{www/} resource path or local copy of the image is needed in the
#' consuming app -- one canonical asset, shipped with the package, the same
#' way \code{grendelshiny_css()}/\code{grendelshiny_js()} inline the shared
#' stylesheet and script.
#'
#' @param alt Alt text for the image. Defaults to \code{"Grendel"}.
#' @param class Optional extra CSS class(es) for the \code{<img>} tag.
#' @return An \code{htmltools} \code{<img>} tag.
#' @examples
#' \dontrun{
#' div(class = "hero-mark", grendel_mark())
#' }
#' @export
grendel_mark <- function(alt = "Grendel", class = NULL) {
  path <- system.file("www/grendel-mark.png", package = "grendelshiny")
  if (!nzchar(path)) {
    stop("grendel-mark.png not found in the installed grendelshiny package")
  }

  uri <- base64enc::dataURI(file = path, mime = "image/png")
  htmltools::tags$img(src = uri, alt = alt, class = class)
}

# Local Variables:
# mode: R
# End:
