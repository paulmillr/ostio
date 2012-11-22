Controller = require 'controllers/base/controller'
User = require 'models/user'
UserPageView = require 'views/user/user_page_view'

module.exports = class UsersController extends Controller
  historyURL: 'users'
  title: 'User'

  show: (params) ->
    @model = new User({login: params.login})
    @view = new UserPageView({@model})
    @model.fetch()
