ChaplinCollection = require 'chaplin/models/collection'
Model = require 'models/model'

module.exports = class Collection extends ChaplinCollection
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
