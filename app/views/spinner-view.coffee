View = require 'views/base/view'
template = require './templates/spinner'

module.exports = class SpinnerView extends View
  autoRender: true
  containerMethod: 'html'
  template: template

  initialize: (options) ->
    super
    @previous = options.container.innerHTML

  dispose: ->
    @container.innerHTML = @previous
    delete @previous
    super
