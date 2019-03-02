const outputs = [];

function onScoreUpdate(dropPosition, bounciness, size, bucketLabel) {
  const sample = [dropPosition, bounciness, size, bucketLabel];
  outputs.push(sample);
}

function runAnalysis() {
  const testSetSize = 50;
  const k = 10;
  const featureCount = outputs[0].length - 1;

  _.range(0, featureCount).forEach(feature => {
    const data = _.map(outputs, row => [row[feature], _.last(row)]);
    const [testSet, trainingSet] = splitDataset(normalizeWithMinMax(data), testSetSize);
    const accuracy = _.chain(testSet)
      .filter(testPoint => knn(trainingSet, _.initial(testPoint), k) === _.last(testPoint))
      .size()
      .divide(testSetSize)
      .value();

    console.log('Accuracy', accuracy, 'for k =', k, 'using feature', feature);
  });
}

function knn(data, point, k) {
  return _.chain(data)
    .map(row => [distance(_.initial(row), point), _.last(row)])
    .sortBy(row => row[0])
    .slice(0, k)
    .countBy(row => row[1])
    .toPairs()
    .sortBy(row => row[1])
    .last()
    .first()
    .parseInt()
    .value();
}

function distance(pointA, pointB) {
  return _.chain(pointA)
    .zip(pointB)
    .map((a, b) => (a - b) ** 2)
    .sum()
    .value() ** 0.5;
}

function splitDataset(data, testCount) {
  const shuffled = _.shuffle(data);

  const testSet = _.slice(shuffled, 0, testCount);
  const trainingSet = _.slice(shuffled, testCount);

  return [testSet, trainingSet];
}

function normalizeWithMinMax(data) {
  const featureCount = data[0].length - 1;
  const normalisedData = _.cloneDeep(data);
  for (let columnIndex = 0; columnIndex < featureCount; columnIndex++) {
    const column = normalisedData.map(row => row[columnIndex]);
    const min = _.min(column);
    const max = _.max(column);
    for (let rowIndex = 0; rowIndex < normalisedData.length; rowIndex++) {
      normalisedData[rowIndex][columnIndex] = (normalisedData[rowIndex][columnIndex] - min) / (max - min);
    }
  }
  return normalisedData;
}
