const tf = require('@tensorflow/tfjs');


class LogisticRegression {

  constructor(features, labels, options) {
    this.features = this.processFeatures(features);
    this.labels = tf.tensor(labels);
    this.costHistory = [];
    this.bHistory = [];

    this.options = Object.assign({
      learningRate: 0.1,
      iterations: 1000,
      batchSize: 10,
      decisionBoundary: 0.5
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
      this.recordCost();
      this.updateLearningRate();
    }
    this.costHistory.reverse();
  }

  //
  predict(observations) {
    return this.processFeatures(observations)
      .matMul(this.weights)
      .sigmoid()
      .greater(this.options.decisionBoundary)
      .cast('float32');
  }

  //
  test(testFeatures, testLabels) {
    const predictions = this.predict(testFeatures);
    testLabels = tf.tensor(testLabels);

    const incorrect = predictions.sub(testLabels).abs().sum().get();
    return (predictions.shape[0] - incorrect) / predictions.shape[0];
  }

  //
  gradientDescent(features, labels) {
    const currentGuesses = features.matMul(this.weights).sigmoid();
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
  recordCost() {
    const guesses = this.features.matMul(this.weights).sigmoid();

    const termOne = this.labels
      .transpose()
      .matMul(guesses.log());

    const termTwo = this.labels
      .mul(-1)
      .add(1)
      .transpose()
      .matMul(
        guesses
          .mul(-1)
          .add(1)
          .log()
      );

    const cost = termOne.add(termTwo)
      .div(this.features.shape[0])
      .mul(-1)
      .get(0, 0);

    this.costHistory.unshift(cost);
  }

  //
  updateLearningRate() {
    if (this.costHistory.length < 2) {
      return;
    }
    if (this.costHistory[0] > this.costHistory[1]) {
      this.options.learningRate /= 2;
    } else {
      this.options.learningRate *= 1.05;
    }
  }

}


module.exports = LogisticRegression;
