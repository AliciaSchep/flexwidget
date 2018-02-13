#' Empty Widget for Custom Javascript
#'
#' The htmlwidgets package allows you to create R interfaces to javascript
#' visualization code. The flexwidget package is a very basic widget that on
#' its own does very little. Rather it sets up the widget so  you can pass in
#' custom javascript and html. See the vignette and examples for an illustration.
#'
#' @param data data to pass to the js_code
#' @param js_code javascript code, should be a function that takes in single
#' argument (the data)
#' @param inner_html html to insert into the widget div
#' @param resize javascript code for resizing, should be a function that takes
#' in width and height argument.
#' @param width width of widget, optional
#' @param height height of widget, optional
#' @param elementId id for widget, optional
#' @param dependencies javascript dependencies, should be list of html_dependency
#' objects created from \code{\link[htmltools]{htmlDependency}}
#'
#' @import htmlwidgets
#' @return an htmlwidget
#'
#' @export
#'
#' @examples
#' # Trivial example: creates an h1 div. passes the data multiplied by 2 to that div.
#' flexwidget(data = 2,
#'   js_code = "function(data){document.getElementById('mydiv').textContent = data * 2}",
#'   inner_html = tags$h1(id = "mydiv"))
#'
#' # Resize example
#' flexwidget(
#'   resize = "function(width, height){document.getElementById('mydiv').textContent = width}",
#'   inner_html = tags$h1("Resize this window to get width", id = "mydiv"))
#'
#' # For more exciting examples see vignette.
#'
flexwidget <- function(data = NULL,
                     js_code = NULL,
                     inner_html = NULL,
                     resize = NULL,
                     width = NULL,
                     height = NULL,
                     elementId = NULL,
                     dependencies = NULL) {
  x <- list()
  x$data <- data

  if (is.null(js_code)) js_code <- "function(){}"
  if (is.null(resize)) resize <- "function(){}"

  # Validate js
  stopifnot(js::js_typeof(js_code) == "function")
  stopifnot(js::js_typeof(resize) == "function")
  stopifnot(js::js_validate_script(paste0("(",js_code,")")))
  stopifnot(js::js_validate_script(paste0("(",resize,")")))

  x$js <- htmlwidgets::JS(js_code)
  x$inner <- htmltools::htmlEscape(inner_html)
  x$resize <- htmlwidgets::JS(resize)

  # create widget
  htmlwidgets::createWidget(
    name = 'flexwidget',
    x,
    width = width,
    height = height,
    package = 'flexwidget',
    elementId = elementId,
    dependencies = dependencies
  )
}

#' Shiny bindings for flexwidget
#'
#' Output and render functions for using flexwidget within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a flexwidget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name flexwidget-shiny
#'
#' @export
flexwidgetOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'flexwidget', width, height, package = 'flexwidget')
}

#' @rdname flexwidget-shiny
#' @export
renderflexwidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, flexwidgetOutput, env, quoted = TRUE)
}
