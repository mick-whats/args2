# args2

[![npm version](https://badge.fury.io/js/args2.svg)](https://badge.fury.io/js/args2)
[![Build Status](https://travis-ci.org/mick-whats/args2-node.svg?branch=master)](https://travis-ci.org/mick-whats/args2-node)
[![Maintainability](https://api.codeclimate.com/v1/badges/e66b304c8e6bb9a713bb/maintainability)](https://codeclimate.com/github/mick-whats/args2-node/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/e66b304c8e6bb9a713bb/test_coverage)](https://codeclimate.com/github/mick-whats/args2-node/test_coverage)

You can easily handle arguments of your own function.

## install

```
npm install args2
```



## use case

This Document is written in coffeeScript, but it also works with javascript.

### case A

#### before

```coffee
sampleFunction = (uri)->
  if typeof uri is 'undefined'
    throw new Error('undefined is not a valid uri or options object.')
```

#### after

```coffee
sampleFunction = ->
  args = new args2(arguments)
  uri = args.str(true,'undefined is not a valid uri or options object.')
```

### case B

#### before

```coffee
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
```

#### after

```coffee
sampleFunction = ->
  args = new args2(arguments)
  callback = args.func()
  options = args.obj(false,{})
  if callback
    callback(null,options)
    return
  else
    return options
```

## Document


### constructor

```coffee
args = new args2(arguments)
```
Always use "arguments" as argument

---

### str(required,default_value)

```coffee
fn = ->
  args = new args2(arguments)
  text1 = args.str(true)
  text2 = args.str(false,'default_value ')
  text3 = args.str()
  return text1 + text2 + text3

console.log fn('hello ','world ','and you')
# result: hello world and you
console.log fn('hello ','world ')
# result: hello world undefined
console.log fn('hello ')
# result: hello default_value undefined
console.log fn()
# throw error: String argument required
```

When required is true
The second argument becomes an error message

```coffee
sampleFunction = ->
  args = new args2(arguments)
  text1 = args.str(true,'custom message')
sampleFunction()
# throw error: custom message
```

---

There are various similar methods

- ### num(required,default_value)
- ### obj(required,default_value)
- ### array(required,default_value)
- ### bool(required,default_value)
- ### func(required,default_value)
- ### other(required,default_value)

---

There are various alias too

- ### string(required,default_value)
- ### number(required,default_value)
- ### object(required,default_value)
- ### arr(required,default_value)
- ### boolean(required,default_value)
- ### function(required,default_value)

---

### rStr(required,default_value)

Method with "r" at the head gets the last argument

```coffee
fn = ->
  args = new args2(arguments)
  text2 = args.rStr(true)
  text1 = args.str()
  return text1 + text2
console.log fn('hello ','world ','and you')
# result: 'hello and you'
console.log fn('hello ','world ')
# result: 'hello world '
console.log fn('hello ')
# result: 'undefinedhello '
console.log fn()
# throw error: String argument required
```

---

There are various similar methods

- ### rNum(required,default_value)
- ### rObj(required,default_value)
- ### rAarray(required,default_value)
- ### rBool(required,default_value)
- ### rFunc(required,default_value)
- ### rOther(required,default_value)

There are various alias too

- ### rNumber(required,default_value)
- ### rObject(required,default_value)
- ### rArr(required,default_value)
- ### rBoolean(required,default_value)
- ### rFunction(required,default_value)
- ### rCallback(required,default_value)

---

### bridge(fn, arguments [,argument_to_add...])

When you are creating classes and functions
I want to pass the argument as it is to another function
In that case, please use "bridge".

```coffee
{bridge} = require 'args2'
# or
args2.bridge
```

```coffee
sum = ->
  args = new args2(arguments)
  return args.nums.reduce (p,c)-> p + c
console.log  sum(1,2,3) #6

bridgeFunction1 = ->
  args2.bridge(sum,arguments)
console.log  bridgeFunction1(2,3,4)# 9

bridgeFunction2 = ->
  args2.bridge(sum,arguments,1)
console.log  bridgeFunction2(2,3,4)# 10

bridgeFunction3 = ->
  args2.bridge(sum,arguments,10,100,1000)
console.log  bridgeFunction3(2,3,4)# 1119
```
