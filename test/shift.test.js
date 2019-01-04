const test = require('ava');
const args2 = require('../lib');

test('shift basic', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    const bl = args.args.length;
    const arg1 = args.shift();
    const al = args.args.length;
    return {bl, al, arg1};
  };
  t.deepEqual(fn('a'), {bl: 1, al: 0, arg1: 'a'});
  t.deepEqual(fn(1, 'a'), {bl: 2, al: 1, arg1: 1});
  t.deepEqual(fn(true, 'a'), {bl: 2, al: 1, arg1: true});
  t.deepEqual(fn({a: 1}, 'a'), {bl: 2, al: 1, arg1: {a: 1}});
  t.deepEqual(fn([1], 'a'), {bl: 2, al: 1, arg1: [1]});
  const res = fn(() => 'x', 'a');
  t.deepEqual(res.bl, 2);
  t.deepEqual(res.al, 1);
  t.deepEqual(res.arg1(), 'x');
});
test('shift required', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.shift(true);
  };
  const err = t.throws(() => fn());
  t.is(err.message, 'argument is required');
});
test('shift required errorMsg', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.shift(true, 'required string argument');
  };
  const err = t.throws(() => fn());
  t.is(err.message, 'required string argument');
});
test('shift not default_value', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.shift(false);
  };
  t.deepEqual(fn(), void 0);
});
test('shift default_value', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.shift(false, 'x');
  };
  t.deepEqual(fn(), 'x');
});
// pop
test('pop basic', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    const bl = args.args.length;
    const arg1 = args.pop();
    const al = args.args.length;
    return {bl, al, arg1};
  };
  t.deepEqual(fn('a'), {bl: 1, al: 0, arg1: 'a'});
  t.deepEqual(fn('a', 1), {bl: 2, al: 1, arg1: 1});
  t.deepEqual(fn('a', true), {bl: 2, al: 1, arg1: true});
  t.deepEqual(fn('a', {a: 1}), {bl: 2, al: 1, arg1: {a: 1}});
  t.deepEqual(fn('a', [1]), {bl: 2, al: 1, arg1: [1]});
  const res = fn('a', () => 'x');
  t.deepEqual(res.bl, 2);
  t.deepEqual(res.al, 1);
  t.deepEqual(res.arg1(), 'x');
});
test('pop required', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.pop(true);
  };
  const err = t.throws(() => fn());
  t.is(err.message, 'argument is required');
});
test('pop required errorMsg', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.pop(true, 'required string argument');
  };
  const err = t.throws(() => fn());
  t.is(err.message, 'required string argument');
});
test('pop not default_value', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.pop(false);
  };
  t.deepEqual(fn(), void 0);
});
test('pop default_value', function(t) {
  const fn = function() {
    const args = new args2(arguments);
    return args.pop(false, 'x');
  };
  t.deepEqual(fn(), 'x');
});
