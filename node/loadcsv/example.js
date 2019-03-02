const loadCSV = require('./load-csv');

const { features, labels, testFeatures, testLabels } = loadCSV('example.csv', {
    dataColumns: ['height', 'value'],
    labelColumns: ['passed'],
    splitTest: 1,
    converters: {
        passed: value => value === 'TRUE'
    }
  });

  console.log('features:', features);
  console.log('labels: ', labels);
  console.log('testFeatures', testFeatures);
  console.log('testLabels: ', testLabels);
