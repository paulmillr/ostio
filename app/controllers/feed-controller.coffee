Controller = require 'controllers/base/controller'
FeedPageView = require 'views/feed/feed-page-view'

module.exports = class FeedController extends Controller
  historyURL: 'feed'
  title: 'Feed'

  show: (params) ->
    @view = new FeedPageView
