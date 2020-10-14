# loadcsv

Loading CSV files with node.js in a form suitable for use in statistical/machine learning algorithms.

## Notes

This is my working of an example from the [Machine Learning with Javascript](https://www.udemy.com/machine-learning-with-javascript/learn/v4/overview) course.

### Libraries

Uses the following npm modules:

* [lodash](https://www.npmjs.com/package/lodash)
* [shuffle-seed](https://www.npmjs.com/package/shuffle-seed)

### Installation/Setup

```bash
$ npm install
```

### Example

The [example.js](./example.js) demonstrates loading a simple CSV file (`example.csv`) with:

* conversion of the `passed` column to boolean
* shuffle and split to data and test set

Example run:

```bash
$ node example.js
features: [ [ 12, 22 ], [ 11, 21 ] ]
labels:  [ [ true ], [ false ] ]
testFeatures [ [ 10, 20 ] ]
testLabels:  [ [ true ] ]
```

## Credits and References

* [Machine Learning with Javascript](https://www.udemy.com/machine-learning-with-javascript/learn/v4/overview)
