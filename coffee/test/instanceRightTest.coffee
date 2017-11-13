args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual
describe "instance test", ->
  it "args", ->
    getArgs = ->
      args = new args2(arguments)
      # String
      assert.lengthOf args.strs,2
      equal args.rStr(),'test2'
      assert.lengthOf args.strs,1
      equal args.rString(),'test1'
      assert.lengthOf args.strs,0
      assert.isUndefined args.rStr()
      # Number
      assert.lengthOf args.nums,2
      equal args.rNum(),222
      assert.lengthOf args.nums,1
      equal args.rNumber(),111
      assert.lengthOf args.nums,0
      assert.isUndefined args.rNum()
      # Object
      assert.lengthOf args.objs,2
      equal args.rObject(),{age:17}
      assert.lengthOf args.objs,1
      equal args.rObj(),{name:'sam'}
      assert.lengthOf args.objs,0
      assert.isUndefined args.rObj()
      #Array
      assert.lengthOf args.arrays,2
      equal args.rArray(),['A','B','C']
      assert.lengthOf args.arrays,1
      equal args.rArr(),[1,2,3]
      assert.lengthOf args.arrays,0
      assert.isUndefined args.rArr()
      # Boolean
      assert.lengthOf args.bools,2
      assert.isFalse args.rBoolean()
      assert.lengthOf args.bools,1
      assert.isTrue args.rBool()
      assert.lengthOf args.bools,0
      assert.isUndefined args.rBool()
      # Function
      assert.lengthOf args.funcs,2
      equal args.rFunction()(),'function2'
      assert.lengthOf args.funcs,1
      equal args.rFunc()(),'function1'
      assert.lengthOf args.funcs,0
      assert.isUndefined args.rFunc()
      # other
      assert.lengthOf args.others,2
      assert.isNull args.rOther()
      assert.lengthOf args.others,1
      assert.isNull args.rOther()
      assert.lengthOf args.others,0
      assert.isUndefined args.rOther()

    fn1 = -> return 'function1'
    fn2 = -> return 'function2'
    # call function
    getArgs('test1','test2',111,222,{name:'sam'},{age:17},[1,2,3],['A','B','C'],true,false,fn1,fn2,null,null)
    # call function Another order
    getArgs([1,2,3],true,null,null,'test1',111,{name:'sam'},fn1,222,{age:17},['A','B','C'],'test2',false,fn2)
describe "required test", ->
  it "required error (String)", ->
    fn = ->
      args = new args2(arguments)
      args.rStr(true)
    assert.throws fn,"String argument required"
  it "required error (Number)", ->
    fn = ->
      args = new args2(arguments)
      args.rNum(true)
    assert.throws fn,"Number argument required"
  it "required error (Object)", ->
    fn = ->
      args = new args2(arguments)
      args.rObj(true)
    assert.throws fn,"Object argument required"
  it "required error (Array)", ->
    fn = ->
      args = new args2(arguments)
      args.rArray(true)
    assert.throws fn,"Array argument required"
  it "required error (Boolean)", ->
    fn = ->
      args = new args2(arguments)
      args.rBool(true)
    assert.throws fn,"Boolean argument required"
  it "required error (Function)", ->
    fn = ->
      args = new args2(arguments)
      args.rFunc(true)
    assert.throws fn,"Function argument required"

describe "default value test", ->
  it "String", ->
    default_test = ->
      args = new args2(arguments)
      equal args.rStr(false,'testVal'),'testVal'
      equal args.rNum(false,123),123
      equal args.rObj(false,{name:'jon'}),{name:'jon'}
      equal args.rArray(false,[1,3,5]),[1,3,5]
      equal args.rBool(false,true),true
      equal args.rFunc(false,()->999)(),999
      equal args.rStr(false,'testVal'),'testVal'

      assert.isUndefined args.rNum(false)
      assert.isUndefined args.rObj(false)
      assert.isUndefined args.rArray(false)
      assert.isUndefined args.rBool(false)
      assert.isUndefined args.rFunc(false)
    default_test()
