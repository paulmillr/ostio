View = require 'views/base/view'
template = require './templates/spinner'

module.exports = class SpinnerView extends View
  autoRender: true
  containerMethod: (container, el) ->
    container.replaceChild el, container.firstChild
  template: template

  initialize: (options) ->
    super
    @previous = options.container.firstChild

  dispose: ->
    return if @disposed
    @containerMethod @container, @previous
    delete @previous
    super
