args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual

describe "readme sample", ->
  it "before 1", ->
    sampleFunction = (uri)->
      if typeof uri is 'undefined'
        throw new Error('undefined is not a valid uri or options object.')
    fn = -> sampleFunction()
    assert.throws fn,/undefined is not a valid uri or options object/
  it "after 1", ->
    sampleFunction = ->
      args = new args2()
      uri = args.str(true,'undefined is not a valid uri or options object.')
    fn = -> sampleFunction()
    assert.throws fn,/undefined is not a valid uri or options object/
  it "before 2", (done)->
    sampleFunction = ->
      args = Array::slice.call(arguments, 0)
      callback = args.pop()
      if typeof callback isnt 'function'
        args.push callback
      options = if args.length then args.shift() else {}
      options = if typeof callback is 'function' then options else callback
      options = if options == null then {} else options
      if typeof callback is 'function'
        callback(null,options)
        return
      else
        return options
    equal sampleFunction({name:'bob'}),{name:'bob'}
    sampleFunction {name:'sum'},(err,res)->
      equal res,{name:'sum'}
      done()
  it "after 2", (done)->
    sampleFunction = ->
      args = new args2(arguments)
      callback = args.func()
      options = args.obj(false,{})
      if callback
        callback(null,options)
        return
      else
        return options
    equal sampleFunction({name:'bob'}),{name:'bob'}
    sampleFunction {name:'sum'},(err,res)->
      equal res,{name:'sum'}
      done()

describe "get", ->
  it "case 1", ->
    sampleFunction = ->
      args = new args2(arguments)
      text1 = args.str(true)
      text2 = args.str(false,'default_value ')
      text3 = args.str()
      return text1 + text2 + text3
    equal sampleFunction('hello ','world ','and you'),'hello world and you'
    equal sampleFunction('hello ','world '),'hello world undefined'
    equal sampleFunction('hello '),'hello default_value undefined'
    assert.throws sampleFunction,/String argument required/
  it "case 2", ->
    sampleFunction = ->
      args = new args2(arguments)
      text1 = args.str(true,'custom message')
    assert.throws (()->sampleFunction()),/custom message/
describe "get right", ->
  it "case 1", ->
    sampleFunction = ->
      args = new args2(arguments)
      text2 = args.rStr(true)
      text1 = args.str()
      return text1 + text2
    equal sampleFunction('hello ','world ','and you'),'hello and you'
    equal sampleFunction('hello ','world '),'hello world '
    equal sampleFunction('hello '),'undefinedhello '
    assert.throws (()->sampleFunction()),/String argument required/

describe "bridge", ->
  sum = ->
    args = new args2(arguments)
    return args.nums.reduce (p,c)-> p + c
  it "baseFunction", ->
    equal sum(1,2,3),6
  it "bridgeFunction", ->
    bridgeFunction1 = ->
      args2.bridge(sum,arguments)
    equal bridgeFunction1(2,3,4),9
  it "bridgeFunction add argument", ->
    bridgeFunction2 = ->
      args2.bridge(sum,arguments,1)
    equal bridgeFunction2(2,3,4),10
  it "bridgeFunction add arguments", ->
    bridgeFunction3 = ->
      args2.bridge(sum,arguments,10,100,1000)
    equal bridgeFunction3(2,3,4),1119

describe "bridge instance", ->
  it "shift", ->
    fn = ->
      args = new args2(arguments)
      args.shift()
      args.bridge (a,b)->
        equal a,'two'
        equal b,'three'
    fn('one','two','three')
  it "pop", ->
    fn = ->
      args = new args2(arguments)
      args.pop()
      args.bridge (a,b)->
        equal a,'one'
        equal b,'two'
    fn('one','two','three')
  it "str", ->
    fn = ->
      args = new args2(arguments)
      args.str()
      args.pass (a,b)->
        equal a,{a:'a'}
        equal b,true
    equal fn({a:'a'},'one',true)
describe "shift and pop", ->
  it "shift", ->
    fn = ->
      args = new args2(arguments)
      text = args.shift()
      return text
    equal fn('one','two','three'),'one'
  it "pop", ->
    fn = ->
      args = new args2(arguments)
      text = args.pop()
      return text
    equal fn('one','two','three'),'three'
