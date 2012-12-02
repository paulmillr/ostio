Controller = require 'controllers/base/controller'
HomePageView = require 'views/home-page-view'

module.exports = class HomeController extends Controller
  historyURL: ''
  title: 'Home'

  show: (params) ->
    @view = new HomePageView
