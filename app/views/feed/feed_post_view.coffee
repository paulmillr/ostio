PostView = require 'views/post/post_view'

module.exports = class FeedPostView extends PostView
  initialize: ->
    super
    @model.setUrl()
