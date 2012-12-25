View = require 'views/base/view'
template = require './templates/spinner'

module.exports = class SpinnerView extends View
  autoRender: yes
  containerMethod: 'html'
  template: template

  initialize: (options) ->
    super
    @previous = options.container.html()

  dispose: ->
    $(@container).html @previous
    delete @previous
    super
