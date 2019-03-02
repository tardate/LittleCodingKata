const fs = require('fs');
const _ = require('lodash');
const shuffleSeed = require('shuffle-seed');

function extractColumns(data, columnNames) {
  const headers = _.first(data);
  const indexes = _.map(columnNames, column => headers.indexOf(column));
  const extracted = _.map(data, row => _.pullAt(row, indexes));
  return extracted;
}


module.exports = function loadCSV(
  filename, {
    converters = {},
    dataColumns = [],
    labelColumns = [],
    shuffle = true,
    splitTest = false
  }
) {
  let data = fs.readFileSync(filename, { encoding: 'utf-8' });
  data = data.split('\n').map(row => row.split(','));
  data = data.map(row => _.dropRightWhile(row, value => value === ''))
  const headers = _.first(data);
  data = data.map((row, index) => {
    if (index === 0) {
      return row;
    }
    return row.map((element, index) => {
      let result;
      if (converters[headers[index]]) {
        result = converters[headers[index]](element);
      } else {
        result = parseFloat(element);
      }
      return _.isNaN(result) ? element : result;
    })
  })

  let labels = extractColumns(data, labelColumns);
  data = extractColumns(data, dataColumns);

  labels.shift();
  data.shift();

  if (shuffle) {
    labels = shuffleSeed.shuffle(labels, 'phrase');
    data = shuffleSeed.shuffle(data, 'phrase');
  }

  if (splitTest) {
    const trainSize = _.isNumber(splitTest) ? splitTest : Math.floor(data.length / 2);
    return {
      features: data.splice(trainSize),
      labels: labels.splice(trainSize),
      testFeatures: data.splice(0, trainSize),
      testLabels: labels.splice(0, trainSize)
    };
  } else {
    return { features: data, labels };
  }
}
