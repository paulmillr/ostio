Chaplin = require 'chaplin'
Backbone = require 'backbone'
Model = require 'models/base/model'

module.exports = class Collection extends Chaplin.Collection
  Backbone.utils.extend @prototype, Chaplin.SyncMachine
  model: Model

  initialize: (models, options) ->
    @url = options.url if options?.url?
    @on 'request', @beginSync
    @on 'sync', @finishSync
    @on 'error', @unsync
    super

  urlPath: ->
    [
      "/users/#{@urlParams.login}"
      "/repos/#{@urlParams.repoName}"
      "/topics/#{@urlParams.topicNumber}"
      "/posts/"
    ].join('')
