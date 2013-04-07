Controller = require 'controllers/base/controller'

module.exports = class AuthController extends Controller
  callback: (params) ->
    _.extend params, _.object window.location.search
      .slice(1).split('&')
      .map((string) -> string.split('='))
    console.log 'AuthController#callback', params
    localStorage.setItem 'accessToken', params.accessToken
    @redirectToRoute 'users#show', [params.login]
    location.reload()

  logout: ->
    @redirectToRoute 'home#show'
    localStorage.clear()
    @publishEvent '!logout'
