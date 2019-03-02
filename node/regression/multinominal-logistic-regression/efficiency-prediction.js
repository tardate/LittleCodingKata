/*
 * Problem: given the horsepower, weight and displacement of a vehicle, will it have high, medium or low fuel efficiency?
 * low:     0 - 15 MPG
 * medium:  15 - 30 MPG
 * high:    30+ MPG
 */
require('@tensorflow/tfjs-node');
const tf = require('@tensorflow/tfjs');
const loadCSV = require('../data/load-csv');
const LogisticRegression = require('./logistic-regression')
const plot = require('node-remote-plot');
const _ = require('lodash');

let { features, labels, testFeatures, testLabels } = loadCSV('../data/cars.csv', {
  shuffle: true,
  splitTest: 50,
  dataColumns: ['horsepower', 'displacement', 'weight'],
  labelColumns: ['mpg'],
  converters: {
    mpg: (value) => {
      const mpg = parseFloat(value);
      if (mpg < 15) {
        return [1, 0, 0];
      } else if (mpg < 30) {
        return [0, 1, 0];
      } else {
        return [0, 0, 1];
      }
    }
  }
});

labels = _.flatMap(labels);
testLabels = _.flatMap(testLabels);

const regression = new LogisticRegression(features, labels, {
  learningRate: 0.5,
  iterations: 100,
  batchSize: 10
});

regression.train();

// regression.predict([[150, 200, 2.223]]).print();

console.log(regression.test(testFeatures, testLabels));

plot({
  x: regression.costHistory,
  xLabel: 'Iteration #',
  yLabel: 'Cost',
  title: 'Cost Convergence',
  name: 'efficiency-prediction-cost'
});
