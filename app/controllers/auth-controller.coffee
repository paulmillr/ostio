Controller = require 'controllers/base/controller'
utils = require 'lib/utils'

module.exports = class AuthController extends Controller
  callback: (params) ->
    parsed = utils.queryParams.parse window.location.search
    Backbone.utils.extend params, parsed
    console.log 'AuthController#callback', params
    @publishEvent 'auth:setToken', params.accessToken
    @redirectToRoute 'users#show', [params.login]
    window.location = window.location.pathname

  logout: ->
    @publishEvent 'auth:setToken', null
    @redirectToRoute 'home#show'
    @publishEvent 'logout'
    window.location = window.location.pathname
