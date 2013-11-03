Controller = require 'controllers/base/controller'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class AuthController extends Controller
  callback: (params) ->
    parsed = utils.queryParams.parse window.location.search
    Backbone.utils.extend params, parsed
    console.log 'AuthController#callback', params
    mediator.login().then =>
      @redirectTo 'users#show', [params.login]
