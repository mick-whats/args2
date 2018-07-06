args2 = require '../'
{ assert } = require 'chai'
_ = require 'lodash'
equal = assert.deepEqual

describe "args2.assign", ->
  it 'case 1', ->
    sampleFn = ->
      [text1, text2, fn] = args2.assign(arguments, ['str' , 'str', 'fn'])
      equal text1, 'a'
      equal text2, 'b'
      equal fn(), true
    sampleFn('a', 'b', -> true)
  it 'case 2', ->
    sampleFn = ->
      [text1, text2, fn] = args2.assign(arguments, ['str' , 'str', 'fn'])
      equal text1, 'a'
      equal text2, undefined
      equal fn(), true
    sampleFn('a', -> true)
  it 'case 3', ->
    sampleFn = ->
      [text1, num1, fn] = args2.assign(arguments, ['str' , 'num', 'fn'])
      equal text1, 'a'
      equal num1, 1
      equal fn(), true
    sampleFn('a', 1, -> true)
  it 'case 4', ->
    sampleFn = ->
      [text1, num1, fn] = args2.assign(arguments, ['str' , 'num', 'fn'])
      equal text1, 'a'
      equal num1, undefined
      equal fn(), true
    sampleFn('a', -> true)
  it 'case 5', ->
    sampleFn = ->
      [text1, obj1, fn] = args2.assign(arguments, ['str' , 'obj', 'fn'])
      equal text1, 'a'
      equal obj1, { foo: 'bar' }
      equal fn(), true
    sampleFn('a', { foo: 'bar' }, -> true)
  it 'case 6', ->
    sampleFn = ->
      [text1, obj1, fn] = args2.assign(arguments, ['str' , 'obj', 'fn'])
      equal text1, 'a'
      equal obj1, undefined
      equal fn(), true
    sampleFn('a', -> true)
  it 'case 7', ->
    sampleFn = ->
      [text1, arr1, fn] = args2.assign(arguments, ['str' , 'arr', 'fn'])
      equal text1, 'a'
      equal arr1, ['x']
      equal fn(), true
    sampleFn('a', ['x'], -> true)
  it 'case 8', ->
    sampleFn = ->
      [text1, arr1, fn] = args2.assign(arguments, ['str' , 'arr', 'fn'])
      equal text1, 'a'
      equal arr1, undefined
      equal fn(), true
    sampleFn('a', -> true)
  it 'case 9', ->
    sampleFn = ->
      [text1, bool1, fn] = args2.assign(arguments, ['str' , 'bool', 'fn'])
      equal text1, 'a'
      equal bool1, false
      equal fn(), true
    sampleFn('a', false, -> true)
  it 'case 10', ->
    sampleFn = ->
      [text1, bool1, fn] = args2.assign(arguments, ['str' , 'bool', 'fn'])
      equal text1, 'a'
      equal bool1, undefined
      equal fn(), true
    sampleFn('a', -> true)
  it 'case 11', ->
    sampleFn = ->
      [text1, num1, fn] = args2.assign(arguments, ['str' , 'num', 'fn'])
      equal text1, 'a'
      equal num1, 1
      equal fn(), true
    sampleFn('a', 1, -> true)
    sampleFn( 1, (-> true), 'a')
  return