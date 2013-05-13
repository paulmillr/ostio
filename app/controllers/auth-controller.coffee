Controller = require 'controllers/base/controller'

module.exports = class AuthController extends Controller
  callback: (params) ->
    _.extend params, _.object window.location.search
      .slice(1).split('&')
      .map((string) -> string.split('='))
    console.log 'AuthController#callback', params
    @publishEvent 'auth:setToken', params.accessToken
    @redirectToRoute 'users#show', [params.login]
    window.location = window.location.pathname

  logout: ->
    @publishEvent 'auth:setToken', null
    @redirectToRoute 'home#show'
    @publishEvent 'logout'
    window.location = window.location.pathname
