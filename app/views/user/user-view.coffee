template = require './templates/user'
View = require 'views/base/view'

module.exports = class UserView extends View
  className: 'user'
  tagName: 'span'
  template: template
