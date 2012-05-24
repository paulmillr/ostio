mediator = require 'mediator'
View = require 'views/view'
template = require 'views/templates/header'

module.exports = class HeaderView extends View
  template: template
  tagName: 'header'
  id: 'header'
  className: 'header'
  containerSelector: '#header-container'
  autoRender: true

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @subscribeEvent 'startupController', @render
