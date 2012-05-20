Controller = require 'controllers/controller'
Thread = require 'models/thread'
ThreadPageView = require 'views/thread_page_view'
User = require 'models/user'
Repo = require 'models/repo'

module.exports = class ThreadsController extends Controller
  historyURL: 'threads'

  redirect_to_repo: (params) ->
    Backbone.history.navigate "/#{params.login}/#{params.repoName}"

  show: (params) ->
    user = new User({login: params.login})
    repo = new Repo({user, name: params.repoName})
    @model = new Thread({repo, number: params.threadNumber})
    @view = new ThreadPageView({@model})
    @model.fetch()
