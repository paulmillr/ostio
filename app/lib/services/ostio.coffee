config = require 'config'
mediator = require 'mediator'
ServiceProvider = require 'lib/services/service_provider'

module.exports = class Ostio extends ServiceProvider
  baseUrl: config.api.root

  constructor: ->
    super
    @accessToken = localStorage.getItem 'accessToken'
    authCallback = _(@loginHandler).bind(this, @loginHandler)
    mediator.subscribe 'auth:callback:ostio', authCallback

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
      mediator.publish 'loginSuccessful', {provider: this, loginContext}

      # Publish the session
      @accessToken = response.accessToken
      localStorage.setItem 'accessToken', @accessToken
      @getUserData().done(@processUserData)
    else
      mediator.publish 'loginFail', provider: this, loginContext: loginContext

  getUserData: ->
    @ajax('get', '/v1/users/me')

  processUserData: (response) ->
    mediator.publish 'userData', response

  getLoginStatus: (callback = @loginStatusHandler, force = false) ->
    @getUserData().always(callback)

  loginStatusHandler: (response, status) =>
    if not response or status is 'error'
      mediator.publish 'logout'
    else
      mediator.publish 'serviceProviderSession', _.extend response,
        provider: this
        userId: response.id
        accessToken: @accessToken
