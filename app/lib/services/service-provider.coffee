utils = require 'lib/utils'

module.exports = class ServiceProvider

  # Mixin an Event Broker
  Backbone.utils.extend @prototype, Chaplin.EventBroker

  loading: false

  constructor: ->
    ###console.debug 'ServiceProvider#constructor'###

    # Mixin a Deferred
    Backbone.utils.extend this, new window.Davy()

    utils.deferMethods
      deferred: this
      methods: ['triggerLogin', 'getLoginStatus']
      onDeferral: @load

  # Disposal
  # --------

  disposed: false

  dispose: ->
    ###console.debug 'ServiceProvider#dispose'###
    return if @disposed

    # Unbind handlers of global events
    @unsubscribeAllEvents()

    # Finished
    @disposed = true

    # You're frozen when your heart’s not open
    Object.freeze? this

###

  Standard methods and their signatures:

  load: ->
    # Load a script like this:
    utils.loadLib 'http://example.org/foo.js', @loadHandler, @reject

  loadHandler: =>
    # Init the library, then resolve
    ServiceProviderLibrary.init(foo: 'bar')
    @resolve()

  isLoaded: ->
    # Return a Boolean
    Boolean window.ServiceProviderLibrary and ServiceProviderLibrary.login

  # Trigger login popup
  triggerLogin: (loginContext) ->
    callback = @loginHandler.bind this, @loginHandler
    ServiceProviderLibrary.login callback

  # Callback for the login popup
  loginHandler: (loginContext, response) =>

    eventPayload = {provider: this, loginContext}
    if response
      # Publish successful login
      @publishEvent 'loginSuccessful', eventPayload

      # Publish the session
      @publishEvent 'serviceProviderSession',
        provider: this
        userId: response.userId
        accessToken: response.accessToken
        # etc.

    else
      @publishEvent 'loginFail', eventPayload

  getLoginStatus: (callback = @loginStatusHandler, force = false) ->
    ServiceProviderLibrary.getLoginStatus callback, force

  loginStatusHandler: (response) =>
    return unless response
    @publishEvent 'serviceProviderSession',
      provider: this
      userId: response.userId
      accessToken: response.accessToken
      # etc.

###
