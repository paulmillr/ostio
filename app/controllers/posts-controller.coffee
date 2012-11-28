Controller = require 'controllers/base/controller'
Post = require 'models/post'
PostView = require 'views/post/post-view'

module.exports = class PostsController extends Controller
  historyURL: 'posts'
  title: 'Post'

  show: (params) ->
    @model = new Post()
    @view = new PostView({@model})
    @model.fetch()
