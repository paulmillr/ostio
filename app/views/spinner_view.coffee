View = require 'views/base/view'
template = require 'views/templates/spinner'

module.exports = class SpinnerView extends View
  template: template
  containerMethod: 'html'
  autoRender: yes

  initialize: (options) ->
    super
    @previous = options.container.html()

  dispose: ->
    $(@container).html @previous
    super
