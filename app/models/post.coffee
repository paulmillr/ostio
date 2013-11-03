Model = require 'models/base/model'
User = require 'models/user'
Repo = require 'models/repo'
Topic = require 'models/topic'

module.exports = class Post extends Model
  urlPath: ->
    "/users/#{@get('topic').get('repo').get('user').get('login')}
/repos/#{@get('topic').get('repo').get('name')}
/topics/#{@get('topic').get('number')}
/posts/"

  parse: (response) ->
    if response
      repoUser = new User Backbone.utils.extend response.topic.repo.user, {}
      repo = new Repo Backbone.utils.extend response.topic.repo, {user: repoUser}
      topic = new Topic Backbone.utils.extend response.topic, {repo}
      user = new User Backbone.utils.extend response.user, {}
      Backbone.utils.extend response, {topic}
