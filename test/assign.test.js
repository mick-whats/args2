const args2 = require('../');
const test = require('ava');

test(`assign ['str', 'str', 'fn']`, function(t) {
  let fn = function() {
    return args2.assign(arguments, ['str', 'str', 'fn']);
  };
  let _args = fn('a', 'b', () => true);
  t.deepEqual(_args[0], 'a');
  t.deepEqual(_args[1], 'b');
  t.deepEqual(_args[2](), true);
  fn = function() {
    return args2.assign(arguments, ['str', 'str', 'func']);
  };
  let [a_, b_, f_] = fn('a', 'b', () => true);
  let [a__, b__, f__] = fn('a', () => true, 'b');
  t.is(a_, a__);
  t.is(b_, b__);
  t.is(f_(), f__());
  fn = function() {
    return args2.assign(arguments, ['str', 'str', 'function']);
  };
  [a_, b_, f_] = fn('a', () => true);
  [a__, b__, f__] = fn(() => true, 'a');
  t.is(b_, void 0);
  t.is(b__, void 0);
  t.is(a_, a__);
  t.is(b_, b__);
  t.is(f_(), f__());
});

test(`assign ['num','obj', 'bool', 'arr','other]`, function(t) {
  const fn = function() {
    return args2.assign(arguments, ['num', 'obj', 'bool', 'arr', '_other']);
  };
  const [b, o, n, a, d] = [true, {a: 1}, 1, ['x'], new Date()];
  let _args = fn(n, a, b, o, d);
  t.deepEqual(_args[0], n);
  t.deepEqual(_args[1], o);
  t.deepEqual(_args[2], b);
  t.deepEqual(_args[3], a);
  t.deepEqual(_args[4], d);

  let [a_, b_, c_, d_] = fn(a, n, o, b);
  let [a__, b__, c__, d__] = fn(n, b, o, a);
  t.is(a_, a__);
  t.deepEqual(b_, b__);
  t.deepEqual(c_, c__);
  t.deepEqual(d_, d__);

  [a_, b_, c_, d_] = fn(a, n);
  [a__, b__, c__, d__] = fn(a, n);
  t.is(b_, void 0);
  t.is(b__, void 0);
  t.is(a_, a__);
  t.deepEqual(b_, b__);
  t.deepEqual(c_, c__);
  t.deepEqual(d_, d__);
});
