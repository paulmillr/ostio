View = require 'views/base/view'
mediator = require 'mediator'

module.exports = class HeaderView extends View
  autoRender: true
  className: 'header'
  events:
    'click .icon-logout': 'logout'
  id: 'header'
  region: 'header'
  tagName: 'header'
  template: require './templates/header'

  listen:
    'loginStatus mediator': 'render'

  logout: (event) ->
    event.preventDefault()
    mediator.logout()
    false
