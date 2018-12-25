const {test} = require('ava');
const args2 = require('../');

test('title', t => {
  t.pass();
});
/*
  describe("instance test (not arguments)", function() {
    return it("args", function() {
      var getArgs;
      getArgs = function() {
        var args;
        args = new args2(arguments);
        return assert.lengthOf(args.args, 0);
      };
      return getArgs();
    });
  });

  describe("instance test", function() {
    it("args", function() {
      var fn1, fn2, getArgs;
      getArgs = function() {
        var args;
        args = new args2(arguments);
        assert.lengthOf(args.strs, 2);
        equal(args.str(), 'test1');
        assert.lengthOf(args.strs, 1);
        equal(args.str(), 'test2');
        assert.lengthOf(args.strs, 0);
        assert.isUndefined(args.str());
        assert.lengthOf(args.nums, 2);
        equal(args.num(), 111);
        assert.lengthOf(args.nums, 1);
        equal(args.num(), 222);
        assert.lengthOf(args.nums, 0);
        assert.isUndefined(args.num());
        assert.lengthOf(args.objs, 2);
        equal(args.obj(), {
          name: 'sam'
        });
        assert.lengthOf(args.objs, 1);
        equal(args.obj(), {
          age: 17
        });
        assert.lengthOf(args.objs, 0);
        assert.isUndefined(args.obj());
        assert.lengthOf(args.arrays, 2);
        equal(args.array(), [1, 2, 3]);
        assert.lengthOf(args.arrays, 1);
        equal(args.array(), ['A', 'B', 'C']);
        assert.lengthOf(args.arrays, 0);
        assert.isUndefined(args.array());
        assert.lengthOf(args.bools, 2);
        assert.isTrue(args.bool());
        assert.lengthOf(args.bools, 1);
        assert.isFalse(args.bool());
        assert.lengthOf(args.bools, 0);
        assert.isUndefined(args.bool());
        assert.lengthOf(args.funcs, 2);
        equal(args.func()(), 'function1');
        assert.lengthOf(args.funcs, 1);
        equal(args.func()(), 'function2');
        assert.lengthOf(args.funcs, 0);
        return assert.isUndefined(args.func());
      };
      fn1 = function() {
        return 'function1';
      };
      fn2 = function() {
        return 'function2';
      };
      getArgs('test1', 'test2', 111, 222, {
        name: 'sam'
      }, {
        age: 17
      }, [1, 2, 3], ['A', 'B', 'C'], true, false, fn1, fn2);
      return getArgs([1, 2, 3], true, 'test1', 111, {
        name: 'sam'
      }, fn1, 222, {
        age: 17
      }, ['A', 'B', 'C'], 'test2', false, fn2);
    });
    return it("alias", function() {
      var alias_test;
      alias_test = function() {
        var args;
        args = new args2(arguments);
        equal(args.string(), 'test1');
        equal(args.number(), 111);
        equal(args.object(), {
          name: 'sam'
        });
        equal(args.arr(), [1, 2, 3]);
        equal(args.boolean(), true);
        return equal(args["function"]()(), 'test function1');
      };
      return alias_test('test1', 111, {
        name: 'sam'
      }, [1, 2, 3], true, function() {
        return 'test function1';
      });
    });
  });


}).call(this);
*/
