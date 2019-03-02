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
      batchSize: 10
    }, options);

    this.weights = tf.zeros([
      this.features.shape[1],
      this.labels.shape[1]
    ]);
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
        this.weights = tf.tidy(() => {

          const featureSlice = this.features.slice([startIndex, 0],[batchSize, -1]);
          const labelsSlice = this.labels.slice([startIndex, 0],[batchSize, -1]);
          return this.gradientDescent(featureSlice, labelsSlice);
        });
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
      .softmax()
      .argMax(1);
  }

  //
  test(testFeatures, testLabels) {
    const predictions = this.predict(testFeatures);
    testLabels = tf.tensor(testLabels).argMax(1);

    const incorrect = predictions
      .notEqual(testLabels)
      .sum()
      .get();

    return (predictions.shape[0] - incorrect) / predictions.shape[0];
  }

  //
  gradientDescent(features, labels) {
    const currentGuesses = features.matMul(this.weights).softmax();
    const differences = currentGuesses.sub(labels);

    const slopes = features
      .transpose()
      .matMul(differences)
      .div(features.shape[0]);

    return this.weights.sub(slopes.mul(this.options.learningRate));
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

      const filler = variance.cast('bool').logicalNot().cast('float32'); // avoid zero variance

      this.mean = mean;
      this.variance = variance.add(filler);
    }
    return features.sub(this.mean).div(this.variance.pow(0.5));
  }

  //
  recordWeights() {
    this.bHistory.push(this.weights.get(0, 0));
  }

  //
  recordCost() {
    const cost = tf.tidy(() => {
      const guesses = this.features.matMul(this.weights).softmax();

      const termOne = this.labels
        .transpose()
        .matMul(
          guesses
            .add(1e-7) // add to avoid log(0)
            .log()
        );

      const termTwo = this.labels
        .mul(-1)
        .add(1)
        .transpose()
        .matMul(
          guesses
            .mul(-1)
            .add(1)
            .add(1e-7) // add to avoid log(0)
            .log()
        );

      return termOne.add(termTwo)
        .div(this.features.shape[0])
        .mul(-1)
        .get(0, 0);
    });
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
