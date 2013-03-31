View = require 'views/base/view'
template = require './templates/header'

module.exports = class HeaderView extends View
  autoRender: yes
  className: 'header'
  id: 'header'
  region: 'header'
  tagName: 'header'
  template: template

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @subscribeEvent 'dispatcher:dispatch', @render
