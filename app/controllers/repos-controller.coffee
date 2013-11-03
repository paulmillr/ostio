Controller = require 'controllers/base/controller'
Repo = require 'models/repo'
RepoPageView = require 'views/repo/repo-page-view'
User = require 'models/user'
Post = require 'models/post'
Collection = require 'models/base/collection'
Topic = require 'models/topic'
TopicsView = require 'views/topic/topics-view'

module.exports = class ReposController extends Controller
  show: (params) ->
    @user = new User {login: params.login}
    @model = new Repo {@user, name: params.repoName}
    @view = new RepoPageView {@model}
    @model.fetch().then =>
      @view.render()
      @topics = new Collection null, model: Topic
      @topics.url = @model.url('/topics/')
      @topicsView = new TopicsView collection: @topics, region: 'topics'
      @topics.fetch()
