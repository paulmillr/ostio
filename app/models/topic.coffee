Model = require 'models/base/model'
User = require 'models/user'
Repo = require 'models/repo'

module.exports = class Topic extends Model
  urlKey: 'number'

  urlPath: ->
    "/users/#{@get('repo').get('user').get('login')}
/repos/#{@get('repo').get('name')}
/topics/"

  parse: (response) ->
    Post = require 'models/post'
    user = new User Backbone.utils.extend response.repo.user, {}
    repo = new Repo Backbone.utils.extend response.repo, {user}
    Backbone.utils.extend response, {repo}
