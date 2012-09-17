View = require 'views/base/view'

module.exports = class PageView extends View
  renderedSubviews: no
  container: '#content-container'

  initialize: ->
    super
    if @model or @collection
      rendered = no
      @modelBind 'change', =>
        @render() unless rendered
        rendered = yes

  getNavigationData: ->
    {}

  renderSubviews: ->
    return

  render: ->
    super
    unless @renderedSubviews
      @renderSubviews()
      @renderedSubviews = yes
    @publishEvent 'navigation:change', @getNavigationData()
