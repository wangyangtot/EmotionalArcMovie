var ALLOWED_ERRORS = 3;


function toggle_elements(chart, button, enable) {
  chart.transition().duration(200).style('opacity', enable);
  if (enable) button.addClass('green').removeClass('grey');
  else button.addClass('grey').removeClass('green');
}


class Receiver {

  constructor(chart_element, button_element, stream_url) {
    this.errors = 0;
    this.running = false;
    this.stream_url = stream_url;
    this.chart_element = chart_element;
    this.button_element = button_element;
  }

  toggle() {
    if (this.running) {
      this.running = false;
      toggle_elements(this.chart_element, this.button_element, 0);
      this.stop();
    }
    else {
      this.running = true;
      toggle_elements(this.chart_element, this.button_element, 1);
      this.start();
    }
  }

  start() {
    this.event_source = new EventSource(this.stream_url);

    this.event_source.onopen = (e) => {
      console.log('Connection opened.');
    };

    this.event_source.addEventListener('initialize', (e) => {
      let data = JSON.parse(e.data);
      this.avatar = new Avatar();
      this.avatar.initialize();
      this.chart = new StreamChart(data);
      this.chart.initialize();
    });

    this.event_source.onmessage = (e) => {
      this.errors = 0;
      let data = JSON.parse(e.data);
      let coords = coords_from_state(data);
      this.avatar.move_to(coords);
      let recommendation = near_recommendation(coords);
      this.avatar.update_recommendations([recommendation].concat(nearest_neighbors(4, recommendation)));
      // this.avatar.update_recommendations(near_recommendation(coords));
      // focus(coords);

      this.chart.plot_data(data);
      // show_label_by_name(near_recommendation(coords), 'labels_search');
    }

    this.event_source.onerror = (e) => {
      this.errors += 1;
      if (this.errors > ALLOWED_ERRORS) this.stop();
    }
  }

  stop() {
    this.avatar.stop();
    this.event_source.close();
  }
}


function coords_from_state(state_values) {
  // var result = {x: 0, y: 0};
  // var names = ['Sublimity', 'Unease', 'Style', 'Vitality'];
  // for (var i = 0; i < names.length; i++) {
  //   let coords = centroid(names[i]);
  //   let ix = i;
  //   if (ix >= state_values.length) ix = state_values.length - 1;
  //   let lambda = state_values[ix]['value'];
  //   result.x += coords.x * lambda;
  //   result.y += coords.y * lambda;
  // }
  vitality = centroid('Unease');
  sublimity = centroid('Sublimity');
  concentration_lambda = state_values[0]['value'];
  relaxation_lambda = state_values[1]['value'];
  return {x: sublimity.x * relaxation_lambda + vitality.x * concentration_lambda,
          y: sublimity.y * relaxation_lambda + vitality.y * concentration_lambda}
  // return result;
}


function near_recommendation(coords){
  var [x_a, y_a] = [coords.x, coords.y];
  for (var i = 0; i < data1.length; i++) {
    var [x_1, y_1] = [data1[i].x, data1[i].y];
    var distance = Math.sqrt(Math.pow(x_a - x_1, 2) + Math.pow(y_a - y_1, 2));
    data1[i].distance = distance;
  }
  var data_temp = data1.slice()
  data_temp.sort(compare);
  return data_temp[0].name;
}

