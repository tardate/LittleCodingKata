const _ = require('lodash');

const loadData = () => {
  const randoms = _.range(0, 999999);
  return randoms;
};

let data = loadData();

debugger;

data = null;

debugger;
