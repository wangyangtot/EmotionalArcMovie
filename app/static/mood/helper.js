function scale_coordinates(array, boundary_x, boundary_y){
    for (var i = 0; i < array.length; i++) {
      array[i][0] = array[i][0] * (boundary_x - 20) + 5;
      array[i][1] = array[i][1] * (boundary_y - 20) + 5;
      array[i][7] = array[i][7] * (boundary_x - 20) + 5;
      array[i][8] = array[i][8] * (boundary_y - 20) + 5;
    }
}


function element_objectizer(array){
    var result = [];
    for (var i = 0; i < array.length; i++) {
        var e = array[i];
        result.push({x: e[0], x_1: e[0], x_2: e[7],
                     y: e[1], y_1: e[1], y_2: e[8],
                     r: e[2], color: e[3], name: e[4],
                     id: e[5], category: e[6]});
    }
    return result;
}



function randomExponential(rate) {
  rate = rate || 1;
  exp = -Math.log(Math.random())/rate;
  while (exp > 1) exp = -Math.log(Math.random())/rate;
  return exp;
}


function compare(a, b) {
  if (a.distance === b.distance) return 0;
  return (a.distance < b.distance) ? -1 : 1;
}


// function checkVisible(elm) {
//   var rect = elm.getBoundingClientRect();
//   var viewHeight = Math.max(document.documentElement.clientHeight, window.innerHeight);
//   return !(rect.bottom < 0 || rect.top - viewHeight >= 0);
// }


function checkVisible(elm) {
  var rect = elm.getBoundingClientRect();
  return ((rect.x + rect.width) < 0 || (rect.y + rect.height) < 0 || (rect.x > window.innerWidth || rect.y > window.innerHeight));
}


$.fn.triggerSVGEvent = function(eventName) {
 var event = document.createEvent('SVGEvents');
 event.initEvent(eventName,true,true);
 this[0].dispatchEvent(event);
 return $(this);
};

