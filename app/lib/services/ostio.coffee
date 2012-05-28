mediator = require 'mediator'
ServiceProvider = require 'lib/services/service_provider'

module.exports = class Ostio extends ServiceProvider
  baseUrl: 'http://ost.io:3000'

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

  ajax: (method, url, data) ->
    url = @baseUrl + url
    url += "?access_token=#{@accessToken}" if @accessToken
    $[method] url, data

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
      @getUserData().success(@processUserData)
    else
      mediator.publish 'loginFail', provider: this, loginContext: loginContext

  getUserData: ->
    @ajax('get', '/v1/users/me')

  processUserData: (response) ->
    mediator.publish 'userData', response

  getLoginStatus: (callback = @loginStatusHandler, force = false) ->
    @getUserData().always(callback)

  loginStatusHandler: (response) =>
    if not response or response.error
      mediator.publish 'logout'
    else
      mediator.publish 'serviceProviderSession', _.extend response,
        provider: this
        userId: response.id
        accessToken: @accessToken
