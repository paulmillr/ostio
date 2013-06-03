config = require 'config'
ServiceProvider = require 'lib/services/service-provider'
User = require 'models/user'

module.exports = class Ostio extends ServiceProvider
  baseUrl: config.api.root

  constructor: ->
    super
    @accessToken = localStorage.getItem 'accessToken'
    authCallback = _.bind(@loginHandler, this, @loginHandler)
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
    @resolve()
    this

  isLoaded: ->
    true

  ajax: (type, url, data) ->
    console.log 'ajax', url, @accessToken, this
    url = @baseUrl + url
    url += "?access_token=#{@accessToken}" if @accessToken
    $.ajax {url, data, type, dataType: 'json'}

  # Trigger login popup
  triggerLogin: (loginContext) ->
    callback = _.bind(@loginHandler, this, @loginHandler)
    window.location = URL

  # Callback for the login popup
  loginHandler: (loginContext, response) =>
    if response
      @setToken response.accessToken

      # Publish successful login
      @publishEvent 'loginSuccessful', {provider: this, loginContext}

      # Publish the session
      @getUserData().done(@processUserData)
    else
      @publishEvent 'loginFail', provider: this, loginContext: loginContext

  getUserData: ->
    @ajax 'get', '/v1/users/me'

  processUserData: (response) ->
    @publishEvent 'userData', response

  getLoginStatus: (callback = @loginStatusHandler, force = false) ->
    @getUserData().always(callback)

  loginStatusHandler: (response, status) =>
    if not response or status is 'error'
      @publishEvent 'logout'
    else
      parsed = User::parse.call(null, response)
      @publishEvent 'serviceProviderSession', _.extend parsed,
        provider: this
        userId: response.id
        accessToken: @accessToken
