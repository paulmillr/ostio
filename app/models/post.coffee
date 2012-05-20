Model = require 'models/model'
User = require 'models/user'
Repo = require 'models/repo'
Thread = require 'models/thread'

module.exports = class Post extends Model
  urlPath: ->
    "/users/#{@get('thread').get('repo').get('user').get('username')}
/repos/#{@get('thread').get('repo').get('name')}
/threads/#{@get('thread').get('number')}
/posts/"

  parse: (response) ->
    user = new User _.extend response.thread.repo.user, {}
    repo = new Repo _.extend response.thread.repo, {user}
    thread = new Thread _.extend response.thread, {repo}
    _.extend response, {thread}
