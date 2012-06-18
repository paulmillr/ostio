Model = require 'models/base/model'
User = require 'models/user'

module.exports = class Repo extends Model
  urlKey: 'name'
  urlPath: ->
    "/users/#{@get('user').get('login')}/repos/"

  parse: (response) ->
    user = new User _.extend response.user, {}
    _.extend response, {user}
