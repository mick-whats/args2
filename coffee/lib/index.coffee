_ = require 'lodash'
class Args2
  isArguments = (args)->
    if toString.call(args) is '[object Arguments]'
      return true
    else
      return false
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
        if defaultValue
          errMsg = defaultValue
        else
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
    return @get('others',required,defaultValue)

  string: Args2::str
  number: Args2::num
  object: Args2::obj
  arr: Args2::array
  boolean: Args2::bool
  function: Args2::func
  callback: Args2::func

  ###
  # argumentsを別のFunctionに丸投げする
  # @param [Function] 丸投げする先のFunction
  # @param [Arguments] 必ずargumentsを指定
  # @option [Argument] 追加する引数があれば指定。可変長引数。
  # @return [???] 丸投げしたFunctionのvalue
  ###
  @bridge: (fn,args,_args...) ->
    args = Array::slice.call(args, 0)
    args = args.concat(_args) if _args.length
    return fn.apply(@,args)
module.exports = Args2
