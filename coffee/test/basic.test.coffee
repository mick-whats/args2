{test} = require 'ava'
args2 = require '../'

errorMsg = 'String argument required'
test 'str', (t) ->
  fn = ->
    args = new args2(arguments)
    t1 = args.str()
    t2 = args.str(true)
    t3 = args.str(false,'default')
    return [t1,t2,t3]
  t.deepEqual fn('t1','t2','t3'), ['t1','t2','t3']
  t.deepEqual fn(1,2,true,'t1',4,'t2',5,'t3'), ['t1','t2','t3']
  t.deepEqual fn('t1','t2'), ['t1','t2','default']
  t1 = t.throws -> fn()
  t.is t1.message, errorMsg
  t2 = t.throws -> fn('t1')
  t.is t2.message, errorMsg

test 'rStr', (t) ->
  fn = ->
    args = new args2(arguments)
    t1 = args.rStr()
    t2 = args.rStr(true)
    t3 = args.rStr(false,'default')
    return [t1,t2,t3]
  t.deepEqual fn('t3','t2','t1'), ['t1','t2','t3']
  t.deepEqual fn(1,2,true,'t1',4,'t2',5,'t3'), ['t3','t2','t1']
  t.deepEqual fn('t1','t2'), ['t2','t1','default']
  t1 = t.throws -> fn()
  t.is t1.message, errorMsg
  t2 = t.throws -> fn('t1')
  t.is t2.message, errorMsg