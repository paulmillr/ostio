PostsView = require 'views/posts_view'
FeedPostView = require 'views/feed_post_view'

module.exports = class FeedPostsView extends PostsView
  itemView: FeedPostView
