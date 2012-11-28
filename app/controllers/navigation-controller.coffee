Controller = require 'controllers/base/controller'
Navigation = require 'models/navigation'
NavigationView = require 'views/navigation-view'

module.exports = class NavigationController extends Controller
  initialize: ->
    super
    @model = new Navigation()
    @view = new NavigationView({@model})
