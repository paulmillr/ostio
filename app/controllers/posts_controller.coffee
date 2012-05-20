Controller = require 'controllers/controller'
Post = require 'models/post'
PostView = require 'views/post_view'

module.exports = class PostsController extends Controller
  historyURL: 'posts'

  show: (params) ->
    @model = new Post()
    @view = new PostView({@model})
    @model.fetch()
