_ = require 'lodash'
class Args2
  # isArguments = (args)->
  #   if toString.call(args) is '[object Arguments]'
  #     return true
  #   else
  #     return false
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

  get: (argType,required,defaultValue,last=false)->
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
      if last
        return argArray.pop()
      else
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

  rStr: (required,defaultValue)->
    return @get('strs',required,defaultValue, true)
  rNum: (required,defaultValue)->
    return @get('nums',required,defaultValue, true)
  rObj: (required,defaultValue)->
    return @get('objs',required,defaultValue, true)
  rArray: (required,defaultValue)->
    return @get('arrays',required,defaultValue, true)
  rBool: (required,defaultValue)->
    return @get('bools',required,defaultValue, true)
  rFunc: (required,defaultValue)->
    return @get('funcs',required,defaultValue, true)
  rOther: (required,defaultValue)->
    return @get('others',required,defaultValue, true)

  rString: Args2::rStr
  rNumber: Args2::rNum
  rObject: Args2::rObj
  rArr: Args2::rArray
  rBoolean: Args2::rBool
  rFunction: Args2::rFunc
  rCallback: Args2::rFunc
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
