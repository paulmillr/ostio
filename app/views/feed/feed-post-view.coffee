PostView = require 'views/post/post-view'

module.exports = class FeedPostView extends PostView
  initialize: ->
    super
    @model.set isFeedPost: yes
