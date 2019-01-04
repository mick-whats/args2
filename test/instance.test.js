const test = require('ava');
const args2 = require('../lib');

test('instance test args', t => {
  const getArgs = function() {
    const args = new args2(arguments);
    // strs
    t.is(args.strs.length, 2);
    t.deepEqual(args.str(), 'test1');
    t.is(args.strs.length, 1);
    t.deepEqual(args.string(), 'test2');
    t.is(args.strs.length, 0);
    t.is(args.str(), void 0);
    // nums
    t.is(args.nums.length, 2);
    t.deepEqual(args.num(), 111);
    t.is(args.nums.length, 1);
    t.deepEqual(args.number(), 222);
    t.is(args.nums.length, 0);
    t.is(args.num(), void 0);
    // objs
    t.is(args.objs.length, 2);
    t.deepEqual(args.object(), {
      name: 'sam'
    });
    t.is(args.objs.length, 1);
    t.deepEqual(args.obj(), {
      age: 17
    });
    t.is(args.objs.length, 0);
    t.is(args.obj(), void 0);
    // arrays
    t.is(args.arrays.length, 2);
    t.deepEqual(args.arr(), [1, 2, 3]);
    t.is(args.arrays.length, 1);
    t.deepEqual(args.array(), ['A', 'B', 'C']);
    t.is(args.arrays.length, 0);
    t.is(args.arr(), void 0);
    // bools
    t.is(args.bools.length, 2);
    t.deepEqual(args.boolean(), true);
    t.is(args.bools.length, 1);
    t.deepEqual(args.bool(), false);
    t.is(args.bools.length, 0);
    t.is(args.bool(), void 0);
    // function
    t.is(args.funcs.length, 2);
    t.deepEqual(args.function()(), 'function1');
    t.is(args.funcs.length, 1);
    t.deepEqual(args.func()(), 'function2');
    t.is(args.funcs.length, 0);
    t.is(args.func(), void 0);
    // other
    t.is(args.others.length, 2);
    t.deepEqual(args.other(), null);
    t.is(args.others.length, 1);
    t.deepEqual(args.other(), null);
    t.is(args.others.length, 0);
    t.is(args.other(), void 0);
  };
  const getArgsR = function() {
    const args = new args2(arguments);
    // strs
    t.is(args.strs.length, 2);
    t.deepEqual(args.rStr(), 'test2');
    t.is(args.strs.length, 1);
    t.deepEqual(args.rString(), 'test1');
    t.is(args.strs.length, 0);
    t.is(args.rStr(), void 0);
    // nums
    t.is(args.nums.length, 2);
    t.deepEqual(args.rNum(), 222);
    t.is(args.nums.length, 1);
    t.deepEqual(args.rNumber(), 111);
    t.is(args.nums.length, 0);
    t.is(args.rNum(), void 0);
    // objs
    t.is(args.objs.length, 2);
    t.deepEqual(args.rObject(), {
      age: 17
    });
    t.is(args.objs.length, 1);
    t.deepEqual(args.rObj(), {
      name: 'sam'
    });
    t.is(args.objs.length, 0);
    t.is(args.rObj(), void 0);
    // arrays
    t.is(args.arrays.length, 2);
    t.deepEqual(args.rArr(), ['A', 'B', 'C']);
    t.is(args.arrays.length, 1);
    t.deepEqual(args.rArray(), [1, 2, 3]);
    t.is(args.arrays.length, 0);
    t.is(args.rArr(), void 0);
    // bools
    t.is(args.bools.length, 2);
    t.deepEqual(args.rBoolean(), false);
    t.is(args.bools.length, 1);
    t.deepEqual(args.rBool(), true);
    t.is(args.bools.length, 0);
    t.is(args.rBool(), void 0);
    // function
    t.is(args.funcs.length, 2);
    t.deepEqual(args.rFunction()(), 'function2');
    t.is(args.funcs.length, 1);
    t.deepEqual(args.rFunc()(), 'function1');
    t.is(args.funcs.length, 0);
    t.is(args.rFunc(), void 0);
    // other
    t.is(args.others.length, 2);
    t.deepEqual(args.rOther(), null);
    t.is(args.others.length, 1);
    t.deepEqual(args.rOther(), null);
    t.is(args.others.length, 0);
    t.is(args.rOther(), void 0);
  };
  const fn1 = () => 'function1';
  const fn2 = () => 'function2';

  const _args1 = [
    'test1',
    'test2',
    111,
    222,
    {
      name: 'sam'
    },
    {
      age: 17
    },
    [1, 2, 3],
    ['A', 'B', 'C'],
    true,
    false,
    fn1,
    fn2,
    null,
    null
  ];

  const _args2 = [
    [1, 2, 3],
    true,
    null,
    null,
    'test1',
    111,
    {
      name: 'sam'
    },
    fn1,
    222,
    {
      age: 17
    },
    ['A', 'B', 'C'],
    'test2',
    false,
    fn2
  ];
  getArgs(..._args1);
  getArgs(..._args2);
  getArgsR(..._args1);
  getArgsR(..._args2);
});

// TODO: requiredTestへ移動
// TODO: custom error messageを追加
test('required error', t => {
  t.plan(24);
  [
    ['str', 'String argument required'],
    ['num', 'Number argument required'],
    ['obj', 'Object argument required'],
    ['arr', 'Array argument required'],
    ['bool', 'Boolean argument required'],
    ['func', 'Function argument required'],
    ['rStr', 'String argument required'],
    ['rNum', 'Number argument required'],
    ['rObj', 'Object argument required'],
    ['rArr', 'Array argument required'],
    ['rBool', 'Boolean argument required'],
    ['rFunc', 'Function argument required']
  ].forEach(method => {
    const fn = function() {
      const args = new args2(arguments);
      return args[method[0]](true);
    };
    const err = t.throws(() => {
      fn();
    }, Error);
    t.is(err.message, method[1]);
    return;
  });
});
// TODO: default_testへ移動
test('default value', t => {
  t.plan(12);
  [
    ['str', 'testVal'],
    ['num', 123],
    ['obj', {a: 1}],
    ['arr', [1, 2, 3]],
    ['bool', true],
    ['func', () => 'testVal'],
    ['rStr', 'testVal'],
    ['rNum', 123],
    ['rObj', {a: 1}],
    ['rArr', [1, 2, 3]],
    ['rBool', true],
    ['rFunc', () => 'testVal']
  ].forEach(method => {
    const fn = function() {
      const args = new args2(arguments);
      return args[method[0]](false, method[1]);
    };
    if (method[0] === 'rFunc' || method[0] === 'func') {
      t.deepEqual(fn()(), method[1]());
    } else {
      t.deepEqual(fn(), method[1]);
    }
    return;
  });
});
