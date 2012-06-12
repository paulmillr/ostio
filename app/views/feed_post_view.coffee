PostView = require 'views/view'

module.exports = class FeedPostView extends PostView
  template: require 'views/templates/post'

  initialize: ->
    super
    @model.setUrl()
