args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual

describe "args.args", ->
  Foo = -> @a =1
  fn1 = -> return 'function1'
  fn2 = -> return 'function2'
  it "str...", ->
    fn = ->
      args = new args2(arguments)
      equal args.args[0],'test1'
      args.str()
      equal args.args[0],'test2'
      args.str()
      equal args.args[0],111
      args.num()
      equal args.args[0],222
      args.num()
      equal args.args[0],{name:'sam'}
      args.arr()
      equal args.args[0],{name:'sam'}
      args.other()
      equal args.args[0],{name:'sam'}
      args.rFunc()
      equal args.args[0],{name:'sam'}
      args.rOther()
      equal args.args[0],{name:'sam'}
      args.bool()
      equal args.args[0],{name:'sam'}
      args.obj()
      equal args.args[0],{age:17}
      args.object()
      equal args.args[0],['A','B','C']
      args.arr()
      equal args.args[0],false
      args.bool()
      equal args.args[0](),'function1'
      args.func()
      assert.lengthOf args.args,0

    fn('test1','test2',111,222,{name:'sam'},new Foo,{age:17},[1,2,3],['A','B','C'],true,false,fn1,fn2,null)

  it "shift", ->
    fn = ->
      args = new args2(arguments)
      assert.lengthOf args.args,14
      assert.lengthOf args.strs,2
      assert.lengthOf args.nums,2
      assert.lengthOf args.objs,2
      assert.lengthOf args.arrays,2
      assert.lengthOf args.bools,2
      assert.lengthOf args.funcs,2
      assert.lengthOf args.others,2
      equal args.shift(),'test1'
      assert.lengthOf args.args,13
      assert.lengthOf args.strs,1
      equal args.shift(),'test2'
      assert.lengthOf args.args,12
      assert.lengthOf args.strs,0
      equal args.shift(),111
      assert.lengthOf args.args,11
      assert.lengthOf args.nums,1
      equal args.shift(),222
      assert.lengthOf args.args,10
      assert.lengthOf args.nums,0
      equal args.shift(),{name:'sam'}
      assert.lengthOf args.args,9
      assert.lengthOf args.objs,1
      equal args.shift().a,1
      assert.lengthOf args.args,8
      assert.lengthOf args.others,1
      equal args.shift(),{age:17}
      assert.lengthOf args.args,7
      assert.lengthOf args.objs,0
      equal args.shift(),[1,2,3]
      assert.lengthOf args.args,6
      assert.lengthOf args.arrays,1
      equal args.shift(),['A','B','C']
      assert.lengthOf args.args,5
      assert.lengthOf args.arrays,0
      equal args.shift(),true
      assert.lengthOf args.args,4
      assert.lengthOf args.bools,1
      equal args.shift(),false
      assert.lengthOf args.args,3
      assert.lengthOf args.bools,0
      equal args.shift()(),'function1'
      assert.lengthOf args.args,2
      assert.lengthOf args.funcs,1
      equal args.shift()(),'function2'
      assert.lengthOf args.args,1
      assert.lengthOf args.funcs,0
      equal args.shift(),null
      assert.lengthOf args.args,0
      assert.lengthOf args.others,0
      equal args.shift(),undefined
      assert.lengthOf args.args,0
      assert.lengthOf args.others,0
    fn('test1','test2',111,222,{name:'sam'},new Foo,{age:17},[1,2,3],['A','B','C'],true,false,fn1,fn2,null)
  it "pop", ->
    fn = ->
      args = new args2(arguments)
      assert.lengthOf args.args,14
      assert.lengthOf args.strs,2
      assert.lengthOf args.nums,2
      assert.lengthOf args.objs,2
      assert.lengthOf args.arrays,2
      assert.lengthOf args.bools,2
      assert.lengthOf args.funcs,2
      assert.lengthOf args.others,2
      equal args.pop(),null
      assert.lengthOf args.args,13
      assert.lengthOf args.others,1
      equal args.pop()(),'function2'
      assert.lengthOf args.args,12
      assert.lengthOf args.funcs,1
      equal args.pop()(),'function1'
      assert.lengthOf args.args,11
      assert.lengthOf args.funcs,0
      equal args.pop(),false
      assert.lengthOf args.args,10
      assert.lengthOf args.bools,1
      equal args.pop(),true
      assert.lengthOf args.args,9
      assert.lengthOf args.bools,0
      equal args.pop(),['A','B','C']
      assert.lengthOf args.args,8
      assert.lengthOf args.arrays,1
      equal args.pop(),[1,2,3]
      assert.lengthOf args.args,7
      assert.lengthOf args.arrays,0
      equal args.pop(),{age:17}
      assert.lengthOf args.args,6
      assert.lengthOf args.objs,1
      equal args.pop().a,1
      assert.lengthOf args.args,5
      assert.lengthOf args.others,0
      equal args.pop(),{name:'sam'}
      assert.lengthOf args.args,4
      assert.lengthOf args.objs,0
      equal args.pop(),222
      assert.lengthOf args.args,3
      assert.lengthOf args.nums,1
      equal args.pop(),111
      assert.lengthOf args.args,2
      assert.lengthOf args.nums,0
      equal args.pop(),'test2'
      assert.lengthOf args.args,1
      assert.lengthOf args.strs,1
      equal args.pop(),'test1'
      assert.lengthOf args.args,0
      assert.lengthOf args.strs,0
      equal args.pop(),undefined
      assert.lengthOf args.args,0
      assert.lengthOf args.others,0
    fn('test1','test2',111,222,{name:'sam'},new Foo,{age:17},[1,2,3],['A','B','C'],true,false,fn1,fn2,null)

  it "shift required",->
    fn = ->
      args = new args2(arguments)
      args.shift(true)
      return
    assert.throws fn,/argument is required/
  it "shift required(with custom message)",->
    fn = ->
      args = new args2(arguments)
      args.shift(true,'custom error message')
      return
    assert.throws fn,/custom error message/
  it "shift with default_value",->
    fn = ->
      args = new args2(arguments)
      args.shift(false,'default_value')
    equal fn(),'default_value'
  it "pop required",->
    fn = ->
      args = new args2(arguments)
      args.pop(true)
      return
    assert.throws fn,/argument is required/
  it "pop required(with custom message)",->
    fn = ->
      args = new args2(arguments)
      args.pop(true,'custom error message')
      return
    assert.throws fn,/custom error message/
  it "pop with default_value",->
    fn = ->
      args = new args2(arguments)
      args.pop(false,'default_value')
    equal fn(),'default_value'


describe "bridge(instance)", ->
  sum = ->
    args = new args2(arguments)
    return args.nums.reduce (p,c)-> p + c
  it "baseFunction", ->
    equal sum(1,2,3),6
  it "bridgeFunction(shift)", ->
    bridgeFunction1 = ->
      args = new args2(arguments)
      omitNumber = args.shift()
      return args.bridge(sum)
    equal bridgeFunction1(2,3,4),7
  it "bridgeFunction(pop)", ->
    bridgeFunction2 = ->
      args = new args2(arguments)
      omitNumber = args.pop()
      return args.bridge(sum)
    equal bridgeFunction2(2,3,4),5
  it "passFunction(shift)", ->
    passFunction1 = ->
      args = new args2(arguments)
      omitNumber = args.shift()
      return args.pass(sum)
    equal passFunction1(2,3,4),7
  it "passFunction(pop)", ->
    passFunction2 = ->
      args = new args2(arguments)
      omitNumber = args.pop()
      return args.pass(sum)
    equal passFunction2(2,3,4),5
