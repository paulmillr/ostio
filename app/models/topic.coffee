Model = require 'models/model'
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
    user = new User _.extend response.repo.user, {}
    repo = new Repo _.extend response.repo, {user}
    topic = _.extend response, {repo}
    first = topic.first_post
    if first
      firstPost = new Post Post::parse(_.extend first, {topic})
      _.extend topic, {first_post: _.extend firstPost, {topic}}
    else
      topic
