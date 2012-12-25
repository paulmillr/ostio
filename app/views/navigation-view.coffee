View = require 'views/base/view'
template = require './templates/navigation'

module.exports = class NavigationView extends View
  className: 'navigation'
  container: '#navigation-container'
  tagName: 'nav'
  template: template

  initialize: ->
    super
    @listenTo @model, 'change', @render
    @subscribeEvent 'navigation:change', (attributes) =>
      @model.clear silent: yes
      @model.set attributes
