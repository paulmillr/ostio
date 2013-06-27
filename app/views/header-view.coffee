View = require 'views/base/view'
template = require './templates/header'

module.exports = class HeaderView extends View
  autoRender: true
  className: 'header'
  id: 'header'
  region: 'header'
  tagName: 'header'
  template: template

  listen:
    'loginStatus mediator': 'render'
