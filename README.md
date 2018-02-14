# flexwidget

The goal of flexwidget is to make it easy to make custom javascript visualizations in R. 

This is just an experiment at the moment, will see if it is useful!

## Example

A widget that takes the input data, multiplies it by 2, and puts it in an h1 div:

``` r
flexwidget(data = 2,
  js_code = "function(data){document.getElementById('mydiv').textContent = data * 2}",
  inner_html = htmltools::tags$h1(id = "mydiv"),
  height = "50px")
```

# 4 <!-- since this is md, widget does not actually get made ... -->

See vignette for visualization example.
