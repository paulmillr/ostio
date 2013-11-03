Controller = require 'controllers/base/controller'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class AuthController extends Controller
  callback: (params) ->
    parsed = utils.queryParams.parse window.location.search.slice(1)
    Backbone.utils.extend params, parsed
    console.log 'AuthController#callback', params
    mediator.login(params.accessToken).then =>
      @redirectTo 'users#show', [params.login]
