PageView = require 'views/page_view'
template = require 'views/templates/feed_page'
config = require 'config'
Collection = require 'models/collection'
Post = require 'models/post'
FeedPostsView = require 'views/feed_posts_view'
User = require 'models/user'
UsersView = require 'views/users_view'

module.exports = class FeedPageView extends PageView
  template: template
  autoRender: yes

  renderSubviews: ->
    users = new Collection null, model: User
    users.url = "#{config.api.versionRoot}/users/"
    @subview 'users', new UsersView
      collection: users,
      container: @$('.user-list-container')
    users.fetch()

    posts = new Collection null, model: Post
    posts.url = "#{config.api.versionRoot}/posts/"
    @subview 'posts', new FeedPostsView
      collection: posts,
      container: @$('.post-list-container')
    posts.fetch()
