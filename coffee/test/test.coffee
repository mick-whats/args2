args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual
describe "args2 test", ->
  it "with this function", ->
    getArgs = ->
      return args2.call(getArgs)
    obj1 =
      name: 'bob'
      age: 21
    function1 = ()-> return 999
    args = getArgs([true,false],1,'2',3,'4',5,'6',obj1,function1)
    equal args.nums[0],1
    equal args.nums[1],3
    equal args.nums[2],5
    equal args.strs[0],'2'
    equal args.strs[1],'4'
    equal args.strs[2],'6'
    equal args.others[0],[true,false]
    equal args.objs[0],{name:'bob',age:21}
    equal args.funcs[0](),999
  it "with arguments", ->
    getArgs = ->
      return args2.call(arguments)
    obj1 =
      name: 'bob'
      age: 21
    function1 = ()-> return 999
    args = getArgs([true,false],1,'2',3,'4',5,'6',obj1,function1)
    equal args.nums[0],1
    equal args.nums[1],3
    equal args.nums[2],5
    equal args.strs[0],'2'
    equal args.strs[1],'4'
    equal args.strs[2],'6'
    equal args.others[0],[true,false]
    equal args.objs[0],{name:'bob',age:21}
    equal args.funcs[0](),999
describe "sample", ->
  sampleFunction = ->
    {strs,nums,funcs} = args2.call(sampleFunction)
    if !funcs.length
      throw new Error('Function is required')
    callback = funcs[0]
    if !strs[0] or !nums[0] or !nums[1]
      callback new Error('Argument is missing')
    text = strs[0]
    sum = nums[0] + nums[1]
    callback(null,{text:text,sum:sum})
  it "sample test", ->
    callback = (err,res)->
      if err
        throw err
      console.log res
    fn1 = ()->sampleFunction()
    assert.throws fn1,'Function is required'
    fn1 = ()->sampleFunction(callback)
    assert.throws fn1,'Argument is missing'
  it "sample test(and callback)",(done) ->
    sampleFunction 'test1',1,2,(err,res)->
      equal res,{text:'test1',sum:3}
      done()
  it "sample test(Another arguments)",(done) ->
    sampleFunction (err,res)->
      equal res,{text:'test2',sum:3}
      done()
    ,1,2,'test2'
