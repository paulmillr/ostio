Controller = require 'controllers/controller'
FeedPageView = require 'views/feed_page_view'

module.exports = class FeedController extends Controller
  historyURL: 'feed'

  show: (params) ->
    @view = new FeedPageView()
