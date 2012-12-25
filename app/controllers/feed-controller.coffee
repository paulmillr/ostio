Controller = require 'controllers/base/controller'
FeedPageView = require 'views/feed/feed-page-view'

module.exports = class FeedController extends Controller
  show: (params) ->
    @view = new FeedPageView
