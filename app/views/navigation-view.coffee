View = require 'views/base/view'
template = require './templates/navigation'

module.exports = class NavigationView extends View
  className: 'navigation'
  listen:
    'change model': 'render'
    'navigation:change mediator': 'clearModel'
  region: 'navigation'
  tagName: 'nav'
  template: template

  clearModel: (attributes) =>
    @model.clear()
    @model.set attributes
