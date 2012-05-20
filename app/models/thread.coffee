Model = require 'models/model'
User = require 'models/user'
Repo = require 'models/repo'

module.exports = class Thread extends Model
  urlKey: 'number'

  urlPath: ->
    "/users/#{@get('repo').get('user').get('username')}
/repos/#{@get('repo').get('name')}
/threads/"

  parse: (response) ->
    Post = require 'models/post'
    user = new User _.extend response.repo.user, {}
    repo = new Repo _.extend response.repo, {user}
    firstPost = new Post Post::parse(response.first_post)
    _.extend response, {repo, first_post: firstPost}
