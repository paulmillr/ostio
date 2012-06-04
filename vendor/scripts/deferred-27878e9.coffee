###
Standalone Deferred
Copyright 2012 Otto Vehviläinen
Released under MIT license

This is a standalone implementation of the wonderful jQuery.Deferred API.
The documentation here is only for quick reference, for complete api please
see the great work of the original project:

http://api.jquery.com/category/deferred-object/
###

unless Array::forEach
  throw new Error "Deferred requires Array.forEach"

###
Store a reference to the global context
###
root = this

###
Tells if an object is observable
###
isObservable = (obj) ->
  (obj instanceof Deferred) or (obj instanceof Promise)

###
Flatten a two dimensional array into one dimension.
Removes elements that are not functions
###
flatten = (args) ->
  return [] unless args
  flatted = []
  args.forEach (item) ->
    if item
      if typeof item is 'function'
        flatted.push(item)
      else
        args.forEach (fn) ->
          if typeof fn is 'function'
            flatted.push(fn)
  flatted


###
Promise object functions as a proxy for a Deferred, except
it does not let you modify the state of the Deferred
###
class Promise
  _deferred: null

  constructor: (deferred) ->
    @_deferred = deferred

  always: (args...) ->
    @_deferred.always(args...)
    this

  done: (args...) ->
    @_deferred.done(args...)
    this

  fail: (args...) ->
    @_deferred.fail(args...)
    this

  pipe: (doneFilter, failFilter) ->
    @_deferred.pipe(doneFilter, failFilter)

  state: ->
    @_deferred.state()

  then: (done, fail) ->
    @_deferred.then(done, fail)
    this

class root.Deferred

  ###
  Initializes a new Deferred. You can pass a function as a parameter
  to be executed immediately after init. The function receives
  the new deferred object as a parameter and this is also set to the
  same object.
  ###
  constructor: (fn) ->
    @_state = 'pending'
    fn.call(this, this) if typeof fn is 'function'

  ###
  Pass in functions or arrays of functions to be executed when the
  Deferred object changes state from pending. If the state is already
  rejected or resolved, the functions are executed immediately. They
  receive the arguments that are passed to reject or resolve and this
  is set to the object defined by rejectWith or resolveWith if those
  variants are used.
  ###
  always: (args...) =>
    return this if args.length is 0
    functions = flatten(args)
    if @_state is 'pending'
      @_alwaysCallbacks or= []
      @_alwaysCallbacks.push(functions...)
    else
      functions.forEach (fn) =>
        fn.apply(@_context, @_withArguments)
    this

  ###
  Pass in functions or arrays of functions to be executed when the
  Deferred object is resolved. If the object has already been resolved,
  the functions are executed immediately. If the object has been rejected,
  nothing happens. The functions receive the arguments that are passed
  to resolve and this is set to the object defined by resolveWith if that
  variant is used.
  ###
  done: (args...) =>
    return this if args.length is 0
    functions = flatten(args)
    if @_state is 'resolved'
      functions.forEach (fn) =>
        fn.apply(@_context, @_withArguments)
    else if @_state is 'pending'
      @_doneCallbacks or= []
      @_doneCallbacks.push(functions...)
    this

  ###
  Pass in functions or arrays of functions to be executed when the
  Deferred object is rejected. If the object has already been rejected,
  the functions are executed immediately. If the object has been resolved,
  nothing happens. The functions receive the arguments that are passed
  to reject and this is set to the object defined by rejectWith if that
  variant is used.
  ###
  fail: (args...) =>
    return this if args.length is 0
    functions = flatten(args)
    if @_state is 'rejected'
      functions.forEach (fn) =>
        fn.apply(@_context, @_withArguments)
    else if @_state is 'pending'
      @_failCallbacks or= []
      @_failCallbacks.push(functions...)
    this

  ###
  Notify progress callbacks. The callbacks get passed the arguments given to notify.
  If the object has resolved or rejected, nothing will happen
  ###
  notify: (args...) =>
    @notifyWith(root, args...)
    this

  ###
  Notify progress callbacks with additional context. Works the same way as notify(),
  except this is set to context when calling the functions.
  ###
  notifyWith: (context, args...) =>
    return this if @_state isnt 'pending'
    @_progressCallbacks?.forEach (fn) ->
      fn.apply(context, args)
    this

  ###
  Returns a new Promise object that's tied to the current Deferred. The doneFilter
  and failFilter can be used to modify the final values that are passed to the
  callbacks of the new promise. If the parameters passed are falsy, the promise
  object resolves or rejects normally. If the filter functions return a value,
  that one is passed to the respective callbacks. The filters can also return a
  new Promise or Deferred object, of which rejected / resolved will control how the
  callbacks fire.
  ###
  pipe: (doneFilter, failFilter) =>
    def = new Deferred()
    @done (args...) ->
      if doneFilter?
        result = doneFilter.apply(this, args)
        if isObservable(result)
          result
            .done (doneArgs...)->
              def.resolveWith.call(def, this, doneArgs...)
            .fail (failArgs...) ->
              def.rejectWith.call(def, this, failArgs...)
        else
          def.resolveWith.call(def, this, result)
      else
        def.resolveWith.call(def, this, args...)
    @fail (args...) ->
      if failFilter?
        result = failFilter.apply(this, args)
        if isObservable(result)
          result
            .done (doneArgs...)->
              def.resolveWith.call(def, this, doneArgs...)
            .fail (failArgs...) ->
              def.rejectWith.call(def, this, failArgs...)
        else
          def.rejectWith.call(def, this, result)
        def.rejectWith.call(def, this, args...)
      else
        def.rejectWith.call(def, this, args...)
    def.promise()

  ###
  Add progress callbacks to be fired when using notify()
  ###
  progress: (args...) =>
    return this if args.length is 0 or @_state isnt 'pending'
    functions = flatten(args)
    @_progressCallbacks or= []
    @_progressCallbacks.push(functions...)
    this

  ###
  Returns the promise object of this Deferred.
  ###
  promise: =>
    @_promise or= new Promise(this)

  ###
  Reject this Deferred. If the object has already been rejected or resolved,
  nothing happens. Parameters passed to reject will be handed to all current
  and future fail and always callbacks.
  ###
  reject: (args...) =>
    @rejectWith(root, args...)
    this

  ###
  Reject this Deferred with additional context. Works the same way as reject, except
  the first parameter is used as this when calling the fail and always callbacks.
  ###
  rejectWith: (context, args...) =>
    return this if @_state isnt 'pending'
    @_state = 'rejected'
    @_withArguments = args
    @_context = context
    @_failCallbacks?.forEach (fn) =>
      fn.apply(@_context, args)
    @_alwaysCallbacks?.forEach (fn) =>
      fn.apply(@_context, args)
    this

  ###
  Resolves this Deferred object. If the object has already been rejected or resolved,
  nothing happens. Parameters passed to resolve will be handed to all current and
  future done and always callbacks.
  ###
  resolve: (args...) =>
    @resolveWith(root, args...)
    this

  ###
  Resolve this Deferred with additional context. Works the same way as resolve, except
  the first parameter is used as this when calling the done and always callbacks.
  ###
  resolveWith: (context, args...) =>
    return this if @_state isnt 'pending'
    @_state = 'resolved'
    @_context = context
    @_withArguments = args
    @_doneCallbacks?.forEach (fn) =>
      fn.apply(@_context, args)
    @_alwaysCallbacks?.forEach (fn) =>
      fn.apply(@_context, args)
    this

  ###
  Returns the state of this Deferred. Can be 'pending', 'rejected' or 'resolved'.
  ###
  state: ->
    @_state

  ###
  Convenience function to specify each done, fail and progress callbacks at the same time.
  ###
  then: (doneCallbacks, failCallbacks, progressCallbacks) =>
    @done(doneCallbacks)
    @fail(failCallbacks)
    @progress(progressCallbacks)
    this

###
Returns a new promise object which will resolve when all of the deferreds or promises
passed to the function resolve. The callbacks receive all the parameters that the
individual resolves yielded as an array. If any of the deferreds or promises are
rejected, the promise will be rejected immediately.
###

root.Deferred.when = (args...) ->
  return new Deferred().resolve().promise() if args.length is 0
  return args[0].promise() if args.length is 1
  allReady = new Deferred()
  readyCount = 0
  allDoneArgs = []

  args.forEach (dfr, index) ->
    dfr
      .done (doneArgs...) ->
        readyCount += 1
        allDoneArgs[index] = doneArgs
        if readyCount is args.length
          allReady.resolve(allDoneArgs...)
      .fail (failArgs...) ->
        allReady.rejectWith(this, failArgs...)
  allReady.promise()

# Install Deferred to Zepto automatically.
do ->
  destination = window.Zepto
  return if not destination or destination.Deferred
  destination.Deferred = ->
    new Deferred()
  origAjax = destination.ajax
  destination.ajax = (options) ->
    deferred = new Deferred()
    createWrapper = (wrapped, finisher) ->
      (args...) ->
        wrapped?(args...)
        finisher(args...)
    options.success = createWrapper options.success, deferred.resolve        
    options.error = createWrapper options.error, deferred.reject
    origAjax(options)
    deferred.promise()
