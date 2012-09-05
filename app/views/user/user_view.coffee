View = require 'views/base/view'
template = require 'views/templates/user'

module.exports = class UserView extends View
  template: template
  className: 'user'
  tagName: 'span'
