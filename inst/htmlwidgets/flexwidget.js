HTMLWidgets.widget({

  name: 'flexwidget',

  type: 'output',

  factory: function(el, width, height) {

    // Create a shared variable that can be used by methods
    var widget;

    return {

      renderValue: function(x) {

        // Shove the html into the widget div
        el.innerHTML = he.decode(x.inner);

        // Run the js code
        x.js(x.data);

        // Store resize method in DOM
        // hack idea from https://github.com/ramnathv/htmlwidgets/issues/19
        el.resizeMethod = x.resize;

      },

      resize: function(width, height) {

        // Get the function you dumped in the DOM
        el.resizeMethod(width, height);


      }

    };
  }
});
