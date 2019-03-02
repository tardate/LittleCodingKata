/*
 * Problem: given the pixel intensity values in an image, identify whether the character is a hand-written 0-9
 *
 * Rune with node --max-old-space-size=4096
 */
require('@tensorflow/tfjs-node');
const tf = require('@tensorflow/tfjs');
const LogisticRegression = require('./logistic-regression')
const plot = require('node-remote-plot');
const _ = require('lodash');
const mnist = require('mnist-data');

function loadTrainingData(samples) {
  const mnistData = mnist.training(0, samples);
  const features = mnistData.images.values.map(image => _.flatMap(image));
  const encodedLabels = mnistData.labels.values.map(label => {
    const row = new Array(10).fill(0);
    row[label] = 1;
    return row
  })
  return { features, labels: encodedLabels }
}

const { features, labels } = loadTrainingData(60000);

const regression = new LogisticRegression(features, labels, {
  learningRate: 1,
  iterations: 80,
  batchSize: 500
});

regression.train();

const testMnistData = mnist.testing(0, 10000);

const testFeatures = testMnistData.images.values.map(image => _.flatMap(image));

const testEncodedLabels = testMnistData.labels.values.map(label => {
    const row = new Array(10).fill(0);
    row[label] = 1;
    return row
})

const accuracy = regression.test(testFeatures, testEncodedLabels);
console.log(accuracy);


plot({
  x: regression.costHistory,
  xLabel: 'Iteration #',
  yLabel: 'Cost',
  title: 'Cost Convergence',
  name: 'image-recognition-cost'
});
