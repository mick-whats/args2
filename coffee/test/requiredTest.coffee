args2 = require '../'
{assert} = require 'chai'
_ = require 'lodash'

describe "required test", ->
  it "string required", ->
    sampleFunction = ->
      args = new args2(arguments)
      text1 = args.str(1)
    fn = -> sampleFunction()
    assert.throws fn,/String argument required/
  it "custom error message", ->
    sampleFunction = ->
      args = new args2(arguments)
      text1 = args.str(1,'undefined is not a valid uri or options object.')
    fn = -> sampleFunction()
    assert.throws fn,/undefined is not a valid uri or options object/
