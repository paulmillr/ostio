PageView = require 'views/page_view'
template = require 'views/templates/topic_page'
Collection = require 'models/collection'
Post = require 'models/post'
PostsView = require 'views/posts_view'
NewPostFormView = require 'views/new_post_form_view'

module.exports = class TopicPageView extends PageView
  template: template

  renderSubviews: ->
    posts = new Collection null, model: Post
    posts.url = @model.url('/posts/')
    @subview 'posts', new PostsView
      collection: posts,
      container: @$('.topic-posts')
    posts.fetch()
    @subscribeEvent 'new:post', (post) =>
      posts.push post

    createNewPost = =>
      newPost = new Post({topic: @model})
      newPostView = new NewPostFormView
        model: newPost,
        container: @$('.new-post-form-container')
      newPostView.on 'dispose', =>
        setTimeout createNewPost, 0
      @subview 'newPostForm', newPostView
    createNewPost()
