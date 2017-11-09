_ = require 'lodash'
class Args2
  # @get:->
  constructor:(@args) ->
    if @arguments?
      args = Array::slice.call(@arguments, 0)
    else if @args
      args = Array::slice.call(@args, 0)
    else
      args = Array::slice.call(@, 0)
    res =
      nums: []
      strs: []
      objs: []
      arrays: []
      bools: []
      funcs: []
      others: []
    args.forEach (item)->
      if _.isNumber(item)
        res.nums.push(item)
      else if _.isString(item)
        res.strs.push(item)
      else if _.isPlainObject(item)
        res.objs.push(item)
      else if _.isArray(item)
        res.arrays.push(item)
      else if _.isBoolean(item)
        res.bools.push(item)
      else if _.isFunction(item)
        res.funcs.push(item)
      else
        res.others.push(item)
    _.merge @,res
    return @

  get: (argType,required,defaultValue)->
    dict =
      strs: 'String'
      nums: 'Number'
      objs: 'Object'
      arrays: 'Array'
      bools: 'Boolean'
      funcs: 'Function'
      others: 'Other'
    argArray = @[argType]
    if argArray.length
      return argArray.shift()
    else
      if required
        errMsg = "#{dict[argType]} argument required"
        throw new Error(errMsg)
      else if _.isUndefined(defaultValue)
        return undefined
      else
        return defaultValue
  str: (required,defaultValue)->
    return @get('strs',required,defaultValue)
  num: (required,defaultValue)->
    return @get('nums',required,defaultValue)
  obj: (required,defaultValue)->
    return @get('objs',required,defaultValue)
  array: (required,defaultValue)->
    return @get('arrays',required,defaultValue)
  bool: (required,defaultValue)->
    return @get('bools',required,defaultValue)
  func: (required,defaultValue)->
    return @get('funcs',required,defaultValue)
  other: (required,defaultValue)->
    return @get('Other',required,defaultValue)

  string: Args2::str
  number: Args2::num
  object: Args2::obj
  arr: Args2::array
  boolean: Args2::bool
  function: Args2::func
  callback: Args2::func


module.exports = Args2
