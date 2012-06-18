mediator = require 'mediator'
Controller = require 'controllers/base/controller'

module.exports = class AuthController extends Controller
  historyURL: 'auth'

  callback: (params) ->
    console.log 'AuthController'
    localStorage.setItem 'accessToken', params.accessToken
    @redirectTo "/#{params.login}"
    window.location.reload()

  logout: ->
    @redirectTo '/'
    localStorage.clear()
    mediator.publish '!logout'
    # window.location.reload()
