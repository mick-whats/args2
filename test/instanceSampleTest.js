// Generated by CoffeeScript 1.10.0
(function() {
  var _, args2, assert, equal;

  args2 = require('../');

  assert = require('chai').assert;

  _ = require('lodash');

  equal = assert.deepEqual;

  describe("instance sample", function() {
    var sampleFunction;
    sampleFunction = function() {
      var args;
      args = new args2(arguments);
      return {
        text1: args.str(),
        text2: args.str(false, 'default value'),
        n1: args.num(),
        obj1: args.obj(false, {}),
        arr1: args.array(false, []),
        bool1: args.bool(false, false),
        function1: args.func(true),
        other1: args.other(false, 1)
      };
    };
    it("get arguments", function() {
      var res;
      res = sampleFunction('hello', 'world', 2, {
        hello: 'world'
      }, [3, 8], true, null, function() {
        return 999;
      });
      equal(res.text1, 'hello');
      equal(res.text2, 'world');
      equal(res.n1, 2);
      equal(res.obj1, {
        hello: 'world'
      });
      equal(res.arr1, [3, 8]);
      equal(res.bool1, true);
      equal(res.function1(), 999);
      return equal(res.other1, null);
    });
    it("required argument - function1", function() {
      var fn;
      fn = function() {
        return sampleFunction();
      };
      return assert.throws(fn, 'Function argument required');
    });
    return it("default Value", function() {
      var fn, res;
      fn = function() {
        return 'value';
      };
      res = sampleFunction(fn);
      equal(res.text1, void 0);
      equal(res.text2, 'default value');
      equal(res.n1, void 0);
      equal(res.obj1, {});
      equal(res.arr1, []);
      equal(res.bool1, false);
      return equal(res.other1, 1);
    });
  });

  describe("alias", function() {
    return it("alias list", function() {
      equal(args2.prototype.string, args2.prototype.str);
      equal(args2.prototype.number, args2.prototype.num);
      equal(args2.prototype.object, args2.prototype.obj);
      equal(args2.prototype.arr, args2.prototype.array);
      equal(args2.prototype.boolean, args2.prototype.bool);
      equal(args2.prototype["function"], args2.prototype.func);
      return equal(args2.prototype.callback, args2.prototype.func);
    });
  });

}).call(this);
