PageView = require 'views/base/page_view'
template = require 'views/templates/topic_page'
Collection = require 'models/base/collection'
Post = require 'models/post'
PostsView = require 'views/posts_view'
NewPostFormView = require 'views/new_post_form_view'

module.exports = class TopicPageView extends PageView
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('repo').get('user').get('gravatar_id'),
    user_login: @model.get('repo').get('user').get('login'),
    repo_name: @model.get('repo').get('name'),
    topic_number: @model.get('number')

  renderSubviews: ->
    posts = new Collection null, model: Post
    posts.url = @model.url('/posts/')
    @subview 'posts', new PostsView
      collection: posts,
      container: @$('.topic-posts-container')
    posts.fetch()
    @subscribeEvent 'post:new', (post) =>
      posts.push post
    @subscribeEvent 'post:edit', (post) =>
      index = posts.indexOf post

    createNewPost = =>
      newPost = new Post({topic: @model})
      newPostView = new NewPostFormView
        model: newPost,
        container: @$('.new-post-form-container')
      newPostView.on 'dispose', =>
        setTimeout createNewPost, 0
      @subview 'newPostForm', newPostView
    createNewPost()
