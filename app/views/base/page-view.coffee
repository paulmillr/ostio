View = require 'views/base/view'

module.exports = class PageView extends View
  region: 'main'

  getNavigationData: ->
    {}

  render: ->
    super
    @publishEvent 'navigation:change', @getNavigationData()
