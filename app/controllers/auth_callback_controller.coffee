Controller = require 'controllers/controller'

module.exports = class AuthCallbackController extends Controller
  historyURL: 'auth_callback'

  initialize: (params) ->
    localStorage.setItem 'accessToken', params.accessToken
    Backbone.history.navigate "/#{params.login}"
    window.location.reload()
