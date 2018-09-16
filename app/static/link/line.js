var wLine = 400;
var hLine = 400;
var margin = {top: 40, right: 10, bottom: 20, left: 50};

// Scale the width and height
var xScaleLine = d3.time.scale()
    .range([margin.left, wLine - margin.right - margin.left])
    .domain([0, 100]);

var yScaleLine = d3.scale.linear()
    .range([hLine - margin.bottom, margin.top])
    .domain([-1, 1]);

// Creat Axes i.e. xAxis and yAxis


var line = d3.svg.line()
    .x(function (d) {
        //console.log(d.point)
        //console.log(xScaleLine(+d.point))
        return xScaleLine(d.point)
            ; // come back here and replace "year"
    })
    .y(function (d) {
        return yScaleLine(d.amount); // come back here and replace "amount"
    })
    .interpolate("basis");

// Create SVG
var linechart = d3.select("#area1")
    .append("svg")
    .attr("width", wLine)
    .attr("height", hLine);

var dataset = []
var activecircle;

for (var i = 0; i < line_data.length; i++) {


    dataset[i] = {
        line_num: i,
        line_points: [],
    }

    for (var j = 0; j < 100; j++) {
        if (line_data[i][j]) {
            //Add a new object to the Div 9 rate line_data array
            //for that district
            dataset[i].line_points.push({
                point: j,
                amount: +line_data[i][j]
            });
        }
    }

}
//console.log(dataset)


var groups = linechart.selectAll("g")
    .data(dataset)
    .enter()
    .append("g")
    .on("mouseover", function (d) {

        activecircle = d.line_num;

        // Setting positio for the district label
        var xPosition = wLine / 2 + 35;
        var yPosition = margin.top - 10;

        linechart.append("text")
            .attr("id", "hoverLabel")
            .attr("x", xPosition)
            .attr("y", yPosition)
            .attr("text-anchor", "start")
            .attr("font-family", "ff-nuvo-sc-web-pro-1,ff-nuvo-sc-web-pro-2, sans-serif")
            .attr("font-size", "20px")
            .text(activecircle);

        d3.selectAll("circle")
            .classed("barLight", function (d) {
                if (d.scatter_num == activecircle) return true;
                else return false;
                //console.log(activescatter);
            });

    }) // end of .on mouseover

    .on("mouseout", function () {
        d3.select("#hoverLabel").remove();

        d3.selectAll("circle")
        //.attr("class", "barBase");
            .attr("fill", function (d) {
                if (d.cluster === "group0") {
                    return "red";
                }
                else if (d.cluster === "group1") {
                    return "orange";
                }
                else if (d.cluster === "group2")
                    return "blue"
                else if (d.cluster === "group3")
                    return "green"
                else if (d.cluster === "group4")
                    return "pink"
                else if (d.cluster === "group5")
                    return "black"
            });


    })

groups.selectAll("path")
    .data(function (d) {
        //console.log([d.line_points])
        return [d.line_points];
    })
    .enter()
    .append("path")
    //.attr("class", "line")
    .attr("d", line);


var xAxisLine = d3.svg.axis()
    .scale(xScaleLine)
    .orient("bottom");
//.ticks(10);

var yAxisLine = d3.svg.axis()
    .scale(yScaleLine)
    .orient("left");

linechart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + (hLine - margin.bottom) + ")")
    .call(xAxisLine);

linechart.append("g")
    .attr("class", "y axis")
    .attr("transform", "translate(" + (margin.left) + ",0)")
    .call(yAxisLine)
    .append("text")
    .attr("x", 0 - margin.left)
    .attr("y", margin.top - 10)
    .style("text-anchor", "start")
    .text("sentiment arc ");
//console.log(points);
//console.log(dataset);

























