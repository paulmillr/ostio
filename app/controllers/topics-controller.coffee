Controller = require 'controllers/base/controller'
Topic = require 'models/topic'
TopicPageView = require 'views/topic/topic-page-view'
User = require 'models/user'
Repo = require 'models/repo'

module.exports = class TopicsController extends Controller
  index: (params) ->
    @redirectToName 'repos#show', params.login, params.repoName

  show: (params) ->
    @user = new User {login: params.login}
    @repo = new Repo {@user, name: params.repoName}
    @model = new Topic {@repo, number: params.topicNumber}
    @view = new TopicPageView {@model}
    @model.fetch().then =>
      @posts = new Collection null, model: Post
      @posts.url = @model.url '/posts/'
      @postsView = new PostsView collection: @posts, region: 'topic-posts'
      @posts.fetch()
