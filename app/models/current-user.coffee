User = require 'models/user'

module.exports = class CurrentUser extends User
  urlKey: ''
  urlPath: ->
    '/users/me'
