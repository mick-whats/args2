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
    @args = args
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

  get: (typingFn,argType,required,defaultValue,last=false)->
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
        ref = argArray.pop()
        if not _.isUndefined(ref)
          refIndex = _.findLastIndex @args,(o)->
            if _.isFunction(typingFn)
              typingFn(o)
            else
              ref is o
          @args.splice(refIndex,1)
        return ref
      else
        ref = argArray.shift()
        if not _.isUndefined(ref)
          refIndex = _.findIndex @args,(o)->
            if _.isFunction(typingFn)
              typingFn(o)
            else
              ref is o
          @args.splice(refIndex,1)
        return ref
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
    return @get(_.isString,'strs',required,defaultValue)
  num: (required,defaultValue)->
    return @get(_.isNumber,'nums',required,defaultValue)
  obj: (required,defaultValue)->
    return @get(_.isPlainObject,'objs',required,defaultValue)
  array: (required,defaultValue)->
    return @get(_.isArray,'arrays',required,defaultValue)
  bool: (required,defaultValue)->
    return @get(_.isBoolean,'bools',required,defaultValue)
  func: (required,defaultValue)->
    return @get(_.isFunction,'funcs',required,defaultValue)
  other: (required,defaultValue)->
    return @get(null,'others',required,defaultValue)

  string: Args2::str
  number: Args2::num
  object: Args2::obj
  arr: Args2::array
  boolean: Args2::bool
  function: Args2::func
  callback: Args2::func

  rStr: (required,defaultValue)->
    return @get(_.isString,'strs',required,defaultValue, true)
  rNum: (required,defaultValue)->
    return @get(_.isNumber,'nums',required,defaultValue, true)
  rObj: (required,defaultValue)->
    return @get(_.isPlainObject,'objs',required,defaultValue, true)
  rArray: (required,defaultValue)->
    return @get(_.isArray,'arrays',required,defaultValue, true)
  rBool: (required,defaultValue)->
    return @get(_.isBoolean,'bools',required,defaultValue, true)
  rFunc: (required,defaultValue)->
    return @get(_.isFunction,'funcs',required,defaultValue, true)
  rOther: (required,defaultValue)->
    return @get(null,'others',required,defaultValue, true)

  rString: Args2::rStr
  rNumber: Args2::rNum
  rObject: Args2::rObj
  rArr: Args2::rArray
  rBoolean: Args2::rBool
  rFunction: Args2::rFunc
  rCallback: Args2::rFunc

  shift: (required,defaultValue)->
    if @args.length
      ref = @args[0]
      switch on
        when _.isString(ref)
          return @str()
        when _.isNumber(ref)
          return @num()
        when _.isArray(ref)
          return @arr()
        when _.isPlainObject(ref)
          return @obj()
        when _.isBoolean(ref)
          return @bool()
        when _.isFunction(ref)
          return @func()
        else
          return @other()
    else
      if required
        if defaultValue
          errMsg = defaultValue
        else
          errMsg = "argument is required"
        throw new Error(errMsg)
      else if _.isUndefined(defaultValue)
        return undefined
      else
        return defaultValue

  pop: (required,defaultValue)->
    if @args.length
      ref = _.last(@args)
      switch on
        when _.isString(ref)
          return @rStr()
        when _.isNumber(ref)
          return @rNum()
        when _.isArray(ref)
          return @rArr()
        when _.isPlainObject(ref)
          return @rObj()
        when _.isBoolean(ref)
          return @rBool()
        when _.isFunction(ref)
          return @rFunc()
        else
          return @rOther()
    else
      if required
        if defaultValue
          errMsg = defaultValue
        else
          errMsg = "argument is required"
        throw new Error(errMsg)
      else if _.isUndefined(defaultValue)
        return undefined
      else
        return defaultValue
  bridge:(fn,_this)->
    _this = _this or {}
    return fn.apply(@,@args)
  pass: Args2::bridge
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

  @assign: (argu, types) ->
    args = new Args2(argu)
    res = []
    types.forEach (type) ->
      res.push switch type
        when 'str', 'string'
          args.str()
        when 'num', 'number'
          args.num()
        when 'obj', 'object'
          args.obj()
        when 'arr', 'array'
          args.arr()
        when 'bool', 'boolean'
          args.bool()
        when 'func', 'function', 'fn'
          args.func()
        else
          args.other()
    return res

module.exports = Args2
