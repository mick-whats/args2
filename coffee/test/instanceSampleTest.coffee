args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual


sampleFunction = ->
  args = new args2(arguments)
  return {
    text1 : args.str()
    text2 : args.str(false,'default value')
    n1 : args.num()
    obj1 : args.obj(false,{})
    arr1 : args.array(false,[])
    bool1 : args.bool(false,false)
    function1 : args.func(true)
    other1: args.other(false,1)
  }
describe "instance sample", ->
  it "get arguments", ->
    res = sampleFunction('hello','world',2,{hello:'world'},[3,8],true,null,()->999)
    equal res.text1, 'hello'
    equal res.text2, 'world'
    equal res.n1, 2
    equal res.obj1, {hello:'world'}
    equal res.arr1, [3,8]
    equal res.bool1, true
    equal res.function1(),999
    equal res.other1, null
  it "get arguments(Another Order)", ->
    res = sampleFunction(true,null,'hello',[3,8],2,{hello:'world'},'world',()->999)
    equal res.text1, 'hello'
    equal res.text2, 'world'
    equal res.n1, 2
    equal res.obj1, {hello:'world'}
    equal res.arr1, [3,8]
    equal res.bool1, true
    equal res.function1(),999
    equal res.other1, null
  it "required argument - function1", ->
    fn = -> sampleFunction()
    assert.throws fn,'Function argument required'
  it "default Value", ->
    fn = -> return 'value'
    res = sampleFunction(fn)
    equal res.text1, undefined
    equal res.text2, 'default value'
    equal res.n1, undefined
    equal res.obj1, {}
    equal res.arr1, []
    equal res.bool1, false
    equal res.other1, 1

describe "alias", ->
  it "alias list", ->
    equal args2::string,   args2::str
    equal args2::number,   args2::num
    equal args2::object,   args2::obj
    equal args2::arr,      args2::array
    equal args2::boolean,  args2::bool
    equal args2::function, args2::func
    equal args2::callback, args2::func

describe "bridge", ->
  it "bridge function", ->
    bridgeFunction = ->
      return args2.bridge(sampleFunction,arguments)
    res1 = bridgeFunction('test1',1,2,()->999)
    res2 = sampleFunction('test1',1,2,()->999)
    equal res1.text1,res2.text1
    equal res1.text2,res2.text2
    equal res1.n1,res2.n1
    equal res1.obj1,res2.obj1
    equal res1.arr1,res2.arr1
    equal res1.bool1,res2.bool1
    equal res1.other1,res2.other1
    equal res1.function1(),res2.function1()
  it "bridge function add argument", ->
    baseFunction = ->
      args = new args2(arguments)
      return args.strs.length
    bridgeFunction1 = ->
      return args2.bridge(bridgeFunction2,arguments)
    bridgeFunction2 = ->
      return args2.bridge(baseFunction,arguments,'test3')
    equal baseFunction('text1','text2'),2
    equal bridgeFunction1('text1','text2'),3
    equal bridgeFunction2('text1','text2'),3
# describe "string",->
#   it "basic", ->
#     sampleFunction = ->
#       args = new args2(arguments)
#       text1 = args.str()
#       text2 = args.str()
#       console.log(text1,text2)
#     sampleFunction('hello','world')
#     # result: hello world
#     sampleFunction('hello')
