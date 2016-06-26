
var data = getData();

var layout = {
  title: 'Interactive Ribbon Charts with plotly.js',
  showlegend: false,
  autosize: true,
  width: 600,
  height: 600,
  scene: {
    xaxis: {title: 'Category', type: 'category'},
    yaxis: {title: 'Date', type: 'date'},
    zaxis: {title: 'Value'}
  }
};
Plotly.newPlot('chart', data, layout);

function generateDatapoints(numberOfDatapoints, seed) {
  // generate some random data starting with seed and
  // moving up/down randomly
  var z = seed;
  var data = Array(numberOfDatapoints)
  for(var i=0; i<numberOfDatapoints; i++ ) {
    z = z + Math.random() - 0.5;
    data[i] = [z, z];
  }
  return data;
}

function generateDateArray(numberOfDatapoints) {
  // returns dates as native Javascript Date objects
  var msPerDay = Date.UTC(2000,0,2) - Date.UTC(2000,0,1);
  var baseDate = new Date(2016,1,26);
  var date;
  var data = Array(numberOfDatapoints)
  for(var i=0; i<numberOfDatapoints; i++ ) {
    date = new Date(baseDate.valueOf() + msPerDay * i);
    data[i] = date;
  }
  return data;
}

function generateDateAsMillis(numberOfDatapoints) {
  // returns dates milliseconds since midnight January 1, 1970 UTC
  // just to prove Plotly can handle this format
  var dates = generateDateArray(numberOfDatapoints);
  return dates.map(function(date) {
    return date.valueOf();
  })
}

function generateDateAsStrings(numberOfDatapoints) {
  // returns dates as strings like '2016-02-26'
  // just to prove Plotly can handle this format
  var dates = generateDateArray(numberOfDatapoints);
  return dates.map(function(date) {
    return [date.getFullYear(), date.getMonth() + 1, date.getDate()].join('-');
  })
}

function getData() {
  var colorscale1 = [[0, 'rgb(31,31,128)'], [1, 'rgb(31,31,255)']];
  var colorscale2 = [[0, 'rgb(62,128,62)'], [1, 'rgb(62,255,62)']];
  var colorscale3 = [[0, 'rgb(93,128,93)'], [1, 'rgb(93,255,93)']];
  var colorscale4 = [[0, 'rgb(128,62,62)'], [1, 'rgb(255,62,62)']];

  var numberOfDatapoints = 60;

  var trace1 = {
    z: generateDatapoints(numberOfDatapoints, 8),
    x: Array(numberOfDatapoints).fill(['apple', 1]),
    y: generateDateArray(numberOfDatapoints),
    name: '',
    colorscale: colorscale1,
    type: 'surface',
    showscale: false
  };
  var trace2 = {
    z: generateDatapoints(numberOfDatapoints, 9),
    x: Array(numberOfDatapoints).fill(['orange', 2]),
    y: generateDateAsMillis(numberOfDatapoints),
    name: '',
    colorscale: colorscale2,
    type: 'surface',
    showscale: false
  };
  var trace3 = {
    z: generateDatapoints(numberOfDatapoints, 10),
    x: Array(numberOfDatapoints).fill(['peach', 3]),
    y: generateDateAsStrings(numberOfDatapoints),
    name: '',
    colorscale: colorscale3,
    type: 'surface',
    showscale: false
  };
  var trace4 = {
    z: generateDatapoints(numberOfDatapoints, 11),
    x: Array(numberOfDatapoints).fill(['pear', 4]),
    y: generateDateArray(numberOfDatapoints),
    name: '',
    colorscale: colorscale4,
    type: 'surface',
    showscale: false
  };
  return [trace1, trace2, trace3, trace4];
}
