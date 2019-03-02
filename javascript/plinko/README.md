# plinko

A demonstration of the k-nearest neighbors algorithm implemented in javascript in a browser.

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

This is my working of an example from the [Machine Learning with Javascript](https://www.udemy.com/machine-learning-with-javascript/learn/v4/overview) course.

Plinko is a demonstration of the [k-nearest neighbors algorithm](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm)
implemented in javascript in a browser.

## Identifying Relevant Data

* dropPosition
* bounciness
* ballSize
* bucket

* independent variable -> feature
* dependent variable -> label

## What Type of Problem?

* classification: value of labels beong to discrete set
* regression: value of labels belong to continuous set

## How K-Nearest Neighbor Works

## Multi-Dimensional KNN

## Feature Normalization

* normalize - 0..1
* standardize - normal standard deviation around 0

Normalising with MinMax

    normalized = (value - min) / (max - min)

## Gauging Accuracy

## Feature Selection

* change in drop position - has predictable impact on bucket
* change in bounciness - has impact on bucket, but not predictably

## Running the Demonstration

`open plinko.html`

![asset](./assets/dropping_balls.png?raw=true)

## Credits and References

* [Machine Learning with Javascript](https://www.udemy.com/machine-learning-with-javascript/learn/v4/overview)
* [k-nearest neighbors algorithm](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm)
