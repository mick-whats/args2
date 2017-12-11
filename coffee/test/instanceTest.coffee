args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual
describe "instance test (not arguments)", ->
  it "args", ->
    getArgs = ->
      args = new args2(arguments)
      assert.lengthOf args.args,0
    getArgs()

describe "instance test", ->
  it "args", ->
    getArgs = ->
      args = new args2(arguments)
      # String
      assert.lengthOf args.strs,2
      equal args.str(),'test1'
      assert.lengthOf args.strs,1
      equal args.str(),'test2'
      assert.lengthOf args.strs,0
      assert.isUndefined args.str()
      # Number
      assert.lengthOf args.nums,2
      equal args.num(),111
      assert.lengthOf args.nums,1
      equal args.num(),222
      assert.lengthOf args.nums,0
      assert.isUndefined args.num()
      # Object
      assert.lengthOf args.objs,2
      equal args.obj(),{name:'sam'}
      assert.lengthOf args.objs,1
      equal args.obj(),{age:17}
      assert.lengthOf args.objs,0
      assert.isUndefined args.obj()
      #Array
      assert.lengthOf args.arrays,2
      equal args.array(),[1,2,3]
      assert.lengthOf args.arrays,1
      equal args.array(),['A','B','C']
      assert.lengthOf args.arrays,0
      assert.isUndefined args.array()
      # Boolean
      assert.lengthOf args.bools,2
      assert.isTrue args.bool()
      assert.lengthOf args.bools,1
      assert.isFalse args.bool()
      assert.lengthOf args.bools,0
      assert.isUndefined args.bool()
      # Function
      assert.lengthOf args.funcs,2
      equal args.func()(),'function1'
      assert.lengthOf args.funcs,1
      equal args.func()(),'function2'
      assert.lengthOf args.funcs,0
      assert.isUndefined args.func()
    fn1 = -> return 'function1'
    fn2 = -> return 'function2'
    # call function
    getArgs('test1','test2',111,222,{name:'sam'},{age:17},[1,2,3],['A','B','C'],true,false,fn1,fn2)
    # call function Another order
    getArgs([1,2,3],true,'test1',111,{name:'sam'},fn1,222,{age:17},['A','B','C'],'test2',false,fn2)
  it "alias", ->
    alias_test = ->
      args = new args2(arguments)
      equal args.string(),'test1'
      equal args.number(),111
      equal args.object(),{name:'sam'}
      equal args.arr(),[1,2,3]
      equal args.boolean(),true
      equal args.function()(),'test function1'
    alias_test('test1',111,{name:'sam'},[1,2,3],true,()->'test function1')
describe "required test", ->
  it "required error (String)", ->
    fn = ->
      args = new args2(arguments)
      args.str(true)
    assert.throws fn,"String argument required"
  it "required error (Number)", ->
    fn = ->
      args = new args2(arguments)
      args.num(true)
    assert.throws fn,"Number argument required"
  it "required error (Object)", ->
    fn = ->
      args = new args2(arguments)
      args.obj(true)
    assert.throws fn,"Object argument required"
  it "required error (Array)", ->
    fn = ->
      args = new args2(arguments)
      args.array(true)
    assert.throws fn,"Array argument required"
  it "required error (Boolean)", ->
    fn = ->
      args = new args2(arguments)
      args.bool(true)
    assert.throws fn,"Boolean argument required"
  it "required error (Function)", ->
    fn = ->
      args = new args2(arguments)
      args.func(true)
    assert.throws fn,"Function argument required"

describe "default value test", ->
  it "String", ->
    default_test = ->
      args = new args2(arguments)
      equal args.str(false,'testVal'),'testVal'
      equal args.num(false,123),123
      equal args.obj(false,{name:'jon'}),{name:'jon'}
      equal args.array(false,[1,3,5]),[1,3,5]
      equal args.bool(false,true),true
      equal args.func(false,()->999)(),999
      equal args.str(false,'testVal'),'testVal'

      assert.isUndefined args.num(false)
      assert.isUndefined args.obj(false)
      assert.isUndefined args.array(false)
      assert.isUndefined args.bool(false)
      assert.isUndefined args.func(false)
    default_test()
