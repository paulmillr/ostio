PageView = require 'views/page_view'
template = require 'views/templates/thread_page'
Collection = require 'models/collection'
Post = require 'models/post'
PostsView = require 'views/posts_view'

module.exports = class ThreadPageView extends PageView
  template: template

  renderSubviews: ->
    posts = new Collection null, model: Post
    posts.url = @model.url() + '/posts/'
    @subview 'posts', new PostsView
      collection: posts,
      container: @$('.thread-posts')
    posts.fetch()
