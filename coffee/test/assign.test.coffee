args2 = require '../'
{test} = require 'ava'
_ = require 'lodash'
# t.deepEqual = assert.deept.deepEqual


test 'case 1', (t)->
  sampleFn = ->
    [text1, text2, fn] = args2.assign(arguments, ['str' , 'str', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual text2, 'b'
    t.deepEqual fn(), true
  sampleFn('a', 'b', -> true)
test 'case 2', (t)->
  sampleFn = ->
    [text1, text2, fn] = args2.assign(arguments, ['str' , 'str', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual text2, undefined
    t.deepEqual fn(), true
  sampleFn('a', -> true)
test 'case 3', (t)->
  sampleFn = ->
    [text1, num1, fn] = args2.assign(arguments, ['str' , 'num', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual num1, 1
    t.deepEqual fn(), true
  sampleFn('a', 1, -> true)
test 'case 4', (t)->
  sampleFn = ->
    [text1, num1, fn] = args2.assign(arguments, ['str' , 'num', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual num1, undefined
    t.deepEqual fn(), true
  sampleFn('a', -> true)
test 'case 5', (t)->
  sampleFn = ->
    [text1, obj1, fn] = args2.assign(arguments, ['str' , 'obj', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual obj1, { foo: 'bar' }
    t.deepEqual fn(), true
  sampleFn('a', { foo: 'bar' }, -> true)
test 'case 6', (t)->
  sampleFn = ->
    [text1, obj1, fn] = args2.assign(arguments, ['str' , 'obj', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual obj1, undefined
    t.deepEqual fn(), true
  sampleFn('a', -> true)
test 'case 7', (t)->
  sampleFn = ->
    [text1, arr1, fn] = args2.assign(arguments, ['str' , 'arr', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual arr1, ['x']
    t.deepEqual fn(), true
  sampleFn('a', ['x'], -> true)
test 'case 8', (t)->
  sampleFn = ->
    [text1, arr1, fn] = args2.assign(arguments, ['str' , 'arr', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual arr1, undefined
    t.deepEqual fn(), true
  sampleFn('a', -> true)
test 'case 9', (t)->
  sampleFn = ->
    [text1, bool1, fn] = args2.assign(arguments, ['str' , 'bool', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual bool1, false
    t.deepEqual fn(), true
  sampleFn('a', false, -> true)
test 'case 10', (t)->
  sampleFn = ->
    [text1, bool1, fn] = args2.assign(arguments, ['str' , 'bool', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual bool1, undefined
    t.deepEqual fn(), true
  sampleFn('a', -> true)
test 'case 11', (t)->
  sampleFn = ->
    [text1, num1, fn] = args2.assign(arguments, ['str' , 'num', 'fn'])
    t.deepEqual text1, 'a'
    t.deepEqual num1, 1
    t.deepEqual fn(), true
  sampleFn('a', 1, -> true)
  sampleFn( 1, (-> true), 'a')
test 'case 12', (t)->
  sampleFn = ->
    [delay, fn, params] = args2.assign(arguments, ['num', 'fn'])
    t.deepEqual delay, 100
    t.deepEqual fn(), true
    t.deepEqual params, ['text1', 'bool1']
  sampleFn(100, (-> true), 'text1', 'bool1')
  sampleFn((-> true), 100, 'text1', 'bool1')
return