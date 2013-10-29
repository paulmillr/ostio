config = require 'config'
ServiceProvider = require 'lib/services/service-provider'
User = require 'models/user'

module.exports = class Ostio extends ServiceProvider
  baseUrl: config.api.root

  constructor: ->
    super
    @accessToken = localStorage.getItem 'accessToken'
    authCallback = @loginHandler.bind this, @loginHandler
    @subscribeEvent 'auth:setToken', @setToken
    @subscribeEvent 'auth:callback:ostio', authCallback

  setToken: (token) =>
    console.log 'Ostio#setToken', token
    if token?
      localStorage.setItem 'accessToken', token
    else
      localStorage.clear()
    @accessToken = token

  load: ->
    @fulfill()
    this

  isLoaded: ->
    true

  ajax: (type, url, data) ->
    console.log 'ajax', url, @accessToken, this
    url = @baseUrl + url
    url += "?access_token=#{@accessToken}" if @accessToken
    Backbone.utils.ajax {
      url, data, type, headers: {Accept: 'application/json'}
    }

  # Trigger login popup
  triggerLogin: (loginContext) ->
    callback = @loginHandler.bind this, @loginHandler
    window.location = URL

  # Callback for the login popup
  loginHandler: (loginContext, response) =>
    if response
      @setToken response.accessToken

      # Publish successful login
      @publishEvent 'loginSuccessful', {provider: this, loginContext}

      # Publish the session
      @getUserData().then @processUserData
    else
      @publishEvent 'loginFail', provider: this, loginContext: loginContext

  getUserData: ->
    @ajax 'get', '/v1/users/me'

  processUserData: (response) ->
    @publishEvent 'userData', response

  getLoginStatus: (callback = @loginStatusHandler, force = false) ->
    @getUserData().then(callback, callback)

  loginStatusHandler: (response, status) =>
    if not response or response.status is 401
      @publishEvent 'logout'
    else
      parsed = User::parse.call(null, response)
      @publishEvent 'serviceProviderSession', Backbone.utils.extend parsed,
        provider: this
        userId: response.id
        accessToken: @accessToken
