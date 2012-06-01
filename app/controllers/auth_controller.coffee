mediator = require 'mediator'
Controller = require 'controllers/controller'

module.exports = class AuthController extends Controller
  historyURL: 'auth'

  callback: (params) ->
    localStorage.setItem 'accessToken', params.accessToken
    Backbone.history.navigate "/#{params.login}"
    window.location.reload()

  logout: ->
    Backbone.history.navigate '/'
    localStorage.clear()
    mediator.publish '!logout'
    window.location.reload()
