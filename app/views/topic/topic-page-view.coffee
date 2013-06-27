NewPostFormView = require 'views/post/new-post-form-view'
PageView = require 'views/base/page-view'
Post = require 'models/post'
template = require './templates/topic-page'

module.exports = class TopicPageView extends PageView
  regions:
    '.topic-posts-container': 'posts'
    '.new-post-form-container': 'new-post'
  template: template

  getNavigationData: ->
    gravatar_id: @model.get('repo').get('user').get('gravatar_id'),
    user_login: @model.get('repo').get('user').get('login'),
    repo_name: @model.get('repo').get('name'),
    topic_number: @model.get('number')

  render: ->
    super
    @createNewPost()

  createNewPost: =>
    @newPost?.dispose()
    @newPost = new Post topic: @model
    newPostView = new NewPostFormView model: @newPost, region: 'new-post'
    newPostView.on 'dispose', => setTimeout @createNewPost, 0
    @subview 'newPostForm', newPostView

  dispose: ->
    return if @disposed
    @newPost?.dispose()
    super
