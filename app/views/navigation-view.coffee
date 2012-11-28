View = require 'views/base/view'
template = require 'views/templates/navigation'

module.exports = class NavigationView extends View
  className: 'navigation'
  container: '#navigation-container'
  tagName: 'nav'
  template: template

  initialize: ->
    super
    @modelBind 'change', @render
    @subscribeEvent 'navigation:change', (attributes) =>
      @model.clear(silent: yes)
      @model.set attributes
