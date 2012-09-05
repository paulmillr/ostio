Collection = require 'models/base/collection'
config = require 'config'
FeedPostsView = require 'views/feed/feed_posts_view'
PageView = require 'views/base/page_view'
Post = require 'models/post'
template = require 'views/templates/feed_page'
User = require 'models/user'
UsersView = require 'views/user/users_view'

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
