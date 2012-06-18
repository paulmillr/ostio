Controller = require 'controllers/base/controller'
Topic = require 'models/topic'
TopicPageView = require 'views/topic_page_view'
User = require 'models/user'
Repo = require 'models/repo'

module.exports = class TopicsController extends Controller
  historyURL: 'topics'

  redirect_to_repo: (params) ->
    Backbone.history.navigate "/#{params.login}/#{params.repoName}"

  show: (params) ->
    user = new User({login: params.login})
    repo = new Repo({user, name: params.repoName})
    @model = new Topic({repo, number: params.topicNumber})
    @view = new TopicPageView({@model})
    @model.fetch()
