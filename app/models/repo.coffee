Model = require 'models/base/model'
User = require 'models/user'

module.exports = class Repo extends Model
  urlKey: 'name'
  urlPath: ->
    "/users/#{@get('user').get('login')}/repos/"

  parse: (response) ->
    user = new User Backbone.utils.extend response.user, {}
    Backbone.utils.extend response, {user}
