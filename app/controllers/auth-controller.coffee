Controller = require 'controllers/base/controller'

module.exports = class AuthController extends Controller
  callback: (params) ->
    console.log 'AuthController'
    localStorage.setItem 'accessToken', params.accessToken
    @redirectTo "/#{params.login}"
    window.location.reload()

  logout: ->
    @redirectTo '/'
    localStorage.clear()
    @publishEvent '!logout'
    # window.location.reload()
