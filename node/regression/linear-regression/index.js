require('@tensorflow/tfjs-node');
const tf = require('@tensorflow/tfjs');
const loadCSV = require('../data/load-csv');
const LinearRegression = require('./linear-regression')
const plot = require('node-remote-plot');

let { features, labels, testFeatures, testLabels } = loadCSV('../data/cars.csv', {
  shuffle: true,
  splitTest: 50,
  dataColumns: ['horsepower', 'displacement', 'weight', 'modelyear', 'cylinders'],
  labelColumns: ['mpg']
});

const regression = new LinearRegression(features, labels, {
  iterations: 100,
  batchSize: 10
});

regression.train();

plot({
  x: regression.bHistory,
  y: regression.mseHistory,
  xLabel: 'Value of b',
  yLabel: 'MSE',
  title: 'MSE cf b',
  name: 'mse_v_b'
})

plot({
  x: regression.mseHistory,
  xLabel: 'Iteration #',
  yLabel: 'MSE',
  title: 'MSE Convergence',
  name: 'mse'
})

const r2 = regression.test(testFeatures, testLabels);
console.log('r2:', r2);

regression.predict([
  // ['horsepower', 'displacement', 'weight', 'modelyear', 'cylinders']
  [135, 307, 2, 78, 8]
]).print();
