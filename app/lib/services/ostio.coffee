config = require 'config'
ServiceProvider = require 'lib/services/service-provider'
User = require 'models/user'

module.exports = class Ostio extends ServiceProvider
  baseUrl: config.api.root

  constructor: ->
    super
    @accessToken = localStorage.getItem 'accessToken'
    authCallback = _(@loginHandler).bind(this, @loginHandler)
    @subscribeEvent 'auth:callback:ostio', authCallback

  load: ->
    @resolve()
    this

  isLoaded: ->
    yes

  ajax: (type, url, data) ->
    url = @baseUrl + url
    url += "?access_token=#{@accessToken}" if @accessToken
    $.ajax {url, data, type, dataType: 'json'}

  # Trigger login popup
  triggerLogin: (loginContext) ->
    callback = _(@loginHandler).bind(this, @loginHandler)
    window.location = URL

  # Callback for the login popup
  loginHandler: (loginContext, response) =>
    if response
      # Publish successful login
      @publishEvent 'loginSuccessful', {provider: this, loginContext}

      # Publish the session
      @accessToken = response.accessToken
      localStorage.setItem 'accessToken', @accessToken
      @getUserData().done(@processUserData)
    else
      @publishEvent 'loginFail', provider: this, loginContext: loginContext

  getUserData: ->
    @ajax('get', '/v1/users/me')

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
