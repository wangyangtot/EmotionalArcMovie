var w = 400;
var h = 400;
var marginLine = {top: 40, right: 10, bottom: 20, left: 50};
var full_dataset = []; // 坐标点数据集合
var xRange = Math.random() * 1000; // x坐标的范围
var yRange = Math.random() * 1000; // y坐标的范围
var num = 100; // 点的个数
var padding = 50; // 描点区域距离svg边界的间距


console.log(d2_data);
//console.log(d2_data);
for (var i = 0; i < d2_data.length; i++) {
    full_dataset[i] = {
        scatter_num: d2_data[i].num,
        cluster: d2_data[i].cluster,
        x: +d2_data[i].x,
        y: +d2_data[i].y,
    }
}
console.log(full_dataset);


var xScale = d3.scale.linear().domain([
    d3.min(full_dataset, function (d) {
        return +d.x;
    }),
    d3.max(full_dataset, function (d) {
        return +d.x;
    })
]).range([marginLine.left, w - marginLine.right - marginLine.left]);

var yScale = d3.scale.linear().domain([
    d3.min(full_dataset, function (d) {
        return +d.y - 1;
    }),
    d3.max(full_dataset, function (d) {
        return +d.x;
    })
]).range([h - marginLine.bottom, marginLine.top]);


// 圆点半径的线性比例尺

// 创建svg并插入到body中
var barchart = d3.select('#area2')
    .append('svg')
    .attr({
        'width': w,
        'height': h,
        //'viewBox': 200 200 800 600
    })
//.append("g")
//.attr("transform",
//"translate(" + marginLine.left + "," + marginLine.top + ")");;


// 创建散列点并依据数据集合为点设置属性
var circles = barchart.selectAll('circle')
    .data(full_dataset)
    .enter()
    .append('circle');

circles.attr({
    'cx': function (d) {
        return xScale(+d.x);
    },
    'cy': function (d) {
        return yScale(+d.y);
    },
    'r': 10,
})
//.attr("class", "barBase")
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

// x轴
var xAxis = d3.svg.axis()
    .scale(xScale)
    .orient('bottom');
// 描绘x轴并设置样式和位置
barchart.append('g')
    .attr('class', 'axis')
    .attr('transform', "translate(" + (marginLine.left - 60 ) + "," + (h - marginLine.top ) + ")")
    .call(xAxis);

// y轴
var yAxis = d3.svg.axis()
    .scale(yScale)
    .orient('left');
// 描绘y轴并设置样式和位置
barchart.append('g')
    .attr('class', 'axis')
    .attr('transform', "translate(" + (marginLine.left - 20) + ",0)")
    .call(yAxis);
//rollover functionality
barchart.selectAll("circle")

    .on("mouseover", function (d) {

        activecircle = d.scatter_num;

        linechart.selectAll("g")
            .each(function (d) {
                if (d) {
                    if (d.line_num == activecircle) {
                        console.log(d3.select(this).select("path"));
                        d3.select(this).select("path").classed("pathLight", true);

                        var xPosition = wLine / 2 + 35;
                        var yPosition = marginLine.top - 10;

                        barchart.append("text")
                            .attr("id", "hoverLabel")
                            .attr("x", xPosition)
                            .attr("y", yPosition)
                            .attr("text-anchor", "start")
                            .attr("font-family", "ff-nuvo-sc-web-pro-1,ff-nuvo-sc-web-pro-2, sans-serif")
                            .attr("font-size", "20px")
                            .text(activecircle);

                        return true;

                    }
                    else {
                        return false;
                    }
                }
            })
    })

    .on("mouseout", function () {

        d3.selectAll("path")
            .attr("class", "pathBase");

        d3.select("#hoverLabel").remove();

    });