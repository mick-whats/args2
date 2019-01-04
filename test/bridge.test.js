const test = require('ava');
const args2 = require('../lib');

test('bridge test', t => {
  const sum = function() {
    const args = new args2(arguments);
    return args.nums.reduce((p, c) => p + c);
  };
  t.is(sum(1, 2, 3), 6);

  const b1 = function() {
    return args2.bridge(sum, arguments);
  };
  t.is(b1(1, 2, 3), 6);

  const b2 = function() {
    return args2.bridge(sum, arguments, 1);
  };
  t.is(b2(1, 2, 3), 7);

  const b3 = function() {
    return args2.bridge(sum, arguments, 1, 2);
  };
  t.is(b3(1, 2, 3), 9);

  const b4 = function() {
    const args = new args2(arguments);
    args.shift();
    return args.bridge(sum);
  };
  t.is(b4(1, 2, 3), 5);
});
