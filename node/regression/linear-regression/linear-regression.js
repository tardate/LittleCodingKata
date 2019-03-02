const tf = require('@tensorflow/tfjs');


class LinearRegression {

  constructor(features, labels, options) {
    this.features = this.processFeatures(features);
    this.labels = tf.tensor(labels);
    this.mseHistory = [];
    this.bHistory = [];

    this.options = Object.assign({
      learningRate: 0.1,
      iterations: 1000,
      batchSize: 10
    }, options);

    this.weights = tf.zeros([this.features.shape[1], 1]);
  }

  //
  train() {
    const { batchSize } = this.options;
    const batchCount = Math.floor(
      this.features.shape[0] / batchSize
    );
    for (let i = 0; i < this.options.iterations ; i++) {
      this.recordWeights();
      for (let batch = 0; batch < batchCount ; batch++) {
        const startIndex = batch * batchSize;
        const featureSlice = this.features.slice([startIndex, 0],[batchSize, -1]);
        const labelsSlice = this.labels.slice([startIndex, 0],[batchSize, -1]);
        this.gradientDescent(featureSlice, labelsSlice);
      }
      this.recordMse();
      this.updateLearningRate();
    }
    this.mseHistory.reverse();
  }

  //
  predict(observations) {
    return this.processFeatures(observations).matMul(this.weights);
  }

  //
  test(testFeatures, testLabels) {
    testFeatures = this.processFeatures(testFeatures);
    testLabels = tf.tensor(testLabels);

    const predictions = testFeatures.matMul(this.weights);

    const ss_res = testLabels.sub(predictions)
      .pow(2)
      .sum()
      .get();

    const ss_tot = testLabels.sub(testLabels.mean())
      .pow(2)
      .sum()
      .get();

    return 1 - ss_res / ss_tot;
  }

  //
  gradientDescent(features, labels) {
    const currentGuesses = features.matMul(this.weights);
    const differences = currentGuesses.sub(labels);

    const slopes = features
      .transpose()
      .matMul(differences)
      .div(features.shape[0]);

    this.weights = this.weights.sub(slopes.mul(this.options.learningRate));
  }

  // returns scaled and 1's appended feature tensor
  processFeatures(features) {
    features = tf.tensor(features);
    features = this.standardize(features);
    features = tf.ones([features.shape[0], 1]).concat(features, 1);
    return features;
  }

  // standardizes features; one first run, records mean and variance
  standardize(features) {
    if (!this.mean && !this.variance) {
      const { mean, variance } = tf.moments(features, 0);
      this.mean = mean;
      this.variance = variance;
    }
    return features.sub(this.mean).div(this.variance.pow(0.5));
  }

  //
  recordWeights() {
    this.bHistory.push(this.weights.get(0, 0));
  }

  //
  recordMse() {
    const mse = this.features
      .matMul(this.weights)
      .sub(this.labels)
      .pow(2)
      .sum()
      .div(this.features.shape[0])
      .get();
    this.mseHistory.unshift(mse);
  }

  //
  updateLearningRate() {
    if (this.mseHistory.length < 2) {
      return;
    }
    if (this.mseHistory[0] > this.mseHistory[1]) {
      this.options.learningRate /= 2;
    } else {
      this.options.learningRate *= 1.05;
    }
  }

}


module.exports = LinearRegression;
