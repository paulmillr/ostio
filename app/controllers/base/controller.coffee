Chaplin = require 'chaplin'
SiteView = require 'views/site-view'
HeaderView = require 'views/header-view'
Navigation = require 'models/navigation'
NavigationView = require 'views/navigation-view'

module.exports = class Controller extends Chaplin.Controller
  beforeAction: (params, route) ->
    @reuse 'site', SiteView
    @reuse 'header', HeaderView

    if route.name in ['users#show', 'repos#show', 'topics#show']
      @reuse 'navigation', ->
        @model = new Navigation
        @view = new NavigationView {@model}
