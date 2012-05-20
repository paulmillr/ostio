Model = require 'models/model'

module.exports = class User extends Model
  urlKey: 'login'

  urlPath: ->
    '/users/'
