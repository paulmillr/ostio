Controller = require 'controllers/base/controller'
Repo = require 'models/repo'
RepoPageView = require 'views/repo_page_view'
User = require 'models/user'

module.exports = class ReposController extends Controller
  historyURL: 'repos'

  show: (params) ->
    user = new User({login: params.login})
    @model = new Repo({user, name: params.repoName})
    @view = new RepoPageView({@model})
    @model.fetch()
