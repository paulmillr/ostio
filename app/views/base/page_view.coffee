View = require 'views/base/view'

module.exports = class PageView extends View
  container: '#content-container'
  renderedSubviews: no

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

  dispose: ->
    return if @disposed
    delete this[attr] for attr in ['rendered', 'renderedSubviews']
    super
