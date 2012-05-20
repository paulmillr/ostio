PageView = require 'views/page_view'
template = require 'views/templates/topic_page'
Collection = require 'models/collection'
Post = require 'models/post'
PostsView = require 'views/posts_view'

module.exports = class TopicPageView extends PageView
  template: template

  renderSubviews: ->
    posts = new Collection null, model: Post
    posts.url = @model.url() + '/posts/'
    @subview 'posts', new PostsView
      collection: posts,
      container: @$('.topic-posts')
    posts.fetch()
