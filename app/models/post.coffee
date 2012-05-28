Model = require 'models/model'
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
    user = new User _.extend response.user, {}
    repo = new Repo _.extend response.topic.repo, {user}
    topic = new Topic _.extend response.topic, {repo}
    _.extend response, {topic}
