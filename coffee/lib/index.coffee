_ = require 'lodash'
module.exports = ->
  args = Array::slice.call(@arguments, 0)
  res =
    nums: []
    strs: []
    objs: []
    funcs: []
    others: []
  args.forEach (item)->
    if _.isNumber(item)
      res.nums.push(item)
    else if _.isString(item)
      res.strs.push(item)
    else if _.isPlainObject(item)
      res.objs.push(item)
    else if _.isFunction(item)
      res.funcs.push(item)
    else
      res.others.push(item)
  return res
