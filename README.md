# args2

You can easily handle arguments of your own function.

## install

```
npm install args2
```

## use

```
sampleFunction = ->
  {strs,nums,funcs} = args2.call(sampleFunction)
  if !funcs.length
    throw new Error('Function is required')
  callback = funcs[0]
  if !strs[0] or !nums[0] or !nums[1]
    callback new Error('Argument is missing')
  text = strs[0]
  sum = nums[0] + nums[1]
  callback(null,{text:text,sum:sum})
```


```
callback = (err,res)->
  if err
    throw err
  console.log res
sampleFunction('test1',1,2,callback)
# result { text: 'test1', sum: 3 }

sampleFunction(callback,1,2,'test1')
# result { text: 'test1', sum: 3 }
```
