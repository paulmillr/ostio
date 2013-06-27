View = require 'views/base/view'

module.exports = class PageView extends View
  region: 'main'
  renderedSubviews: no

  getNavigationData: ->
    {}

  renderSubviews: ->
    return

  render: ->
    super
    @publishEvent 'navigation:change', @getNavigationData()
