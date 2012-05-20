Model = require 'models/model'

module.exports = class User extends Model
  urlKey: 'username'

  urlPath: ->
    '/users/'
