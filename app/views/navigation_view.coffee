mediator = require 'mediator'
View = require 'views/view'
template = require 'views/templates/navigation'

module.exports = class NavigationView extends View
  template: template
  id: 'navigation'
  className: 'navigation'
  containerSelector: '#navigation-container'
  autoRender: true

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @subscribeEvent 'startupController', @render
