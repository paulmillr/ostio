Chaplin = require 'chaplin'
Model = require 'models/base/model'

module.exports = class Collection extends Chaplin.Collection
  _(@prototype).extend Chaplin.SyncMachine

  model: Model

  initialize: (models, options) ->
    @url = options.url if options?.url?
    super

  urlPath: ->
    "
/users/#{@urlParams.login}
/repos/#{@urlParams.repoName}
/topics/#{@urlParams.topicNumber}
/posts/"
