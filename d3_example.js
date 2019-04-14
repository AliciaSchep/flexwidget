function(data, width, height){

data = HTMLWidgets.dataframeToD3(data);
console.log(data);

// set the dimensions and margins of the graph
var margin = {top: 20, right: 20, bottom: 30, left: 50};

width = 500 - margin.left - margin.right;
height = 500 - margin.top - margin.bottom;

//console.log(width);
//console.log(height);

// set the ranges
var x = d3.scaleLinear().range([0, width]);
var y = d3.scaleLinear().range([height, 0]);

// append the svg obgect to the body of the page
// appends a 'group' element to 'svg'
// moves the 'group' element to the top left margin
var svg = d3.select("#vis").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

  // Scale the range of the data
  x.domain(d3.extent(data, function(d) { return d.Sepal_Length; }));
  y.domain(d3.extent(data, function(d) { return d.Sepal_Width; }));

  // Add the scatterplot
  svg.selectAll("circle")
   .data(data)
   .enter()
   .append("circle")
      .attr("r", 5)
      .attr("cx", function(d) { return x(d.Sepal_Length); })
      .attr("cy", function(d) { return y(d.Sepal_Width); });

  // Add the X Axis
  svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));

  // Add the Y Axis
  svg.append("g")
      .call(d3.axisLeft(y));
}
