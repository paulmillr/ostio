Controller = require 'controllers/base/controller'
Collection = require 'models/base/collection'
Topic = require 'models/topic'
TopicPageView = require 'views/topic/topic-page-view'
User = require 'models/user'
Repo = require 'models/repo'
Post = require 'models/post'
PostsView = require 'views/post/posts-view'

module.exports = class TopicsController extends Controller
  index: (params) ->
    @redirectToName 'repos#show', params.login, params.repoName

  show: (params) ->
    @user = new User {login: params.login}
    @repo = new Repo {@user, name: params.repoName}
    @model = new Topic {@repo, number: params.topicNumber}
    @view = new TopicPageView {@model}
    @model.fetch().then =>
      @view.render()
      @posts = new Collection null, model: Post
      @posts.url = @model.url '/posts/'
      @postsView = new PostsView collection: @posts, region: 'posts'
      @posts.fetch()
