View = require 'views/view'
template = require 'views/templates/page'

module.exports = class PageView extends View
  template: template
  renderedSubviews: no
  containerSelector: '#content-container'

  initialize: ->
    super
    if @model or @collection
      rendered = no
      @modelBind 'change', =>
        @render() unless rendered
        rendered = yes

  renderSubviews: ->
    return

  render: ->
    super
    unless @renderedSubviews
      @renderSubviews()
      @renderedSubviews = yes
