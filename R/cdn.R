#' Make tag list for javascript or css dependencies
#'
#' Pass CDN urls to knitr document or shiny
#'
#' @param ... urls for javascript or css CDNs
#'
#' @return a tagList with script or style tags for each input URL
#' @export
#' @rdname flexwidget_deps
#' @name flexwidget_dep
#' @return \code{\link[htmltools]{tagList}}
#' @examples
#'
#' flexwidget_src("https://d3js.org/d3.v4.min.js",
#'                "http://dimplejs.org/dist/dimple.v2.3.0.min.js")
#'
flexwidget_src <- function(...) {

  htmltools::tagList(
    lapply(list(...),
           function(x) htmltools::tags$script(type = "text/javascript",
                                              src = x))
  )

}

#' @export
#' @rdname flexwidget_deps
#' @name flexwidget_dep
flexwidget_css <- function(...){

  htmltools::tagList(
    lapply(list(...),
           function(x) htmltools::tags$style(type = "text/css",
                                              src = x))
  )

}
