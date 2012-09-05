PostsView = require 'views/post/posts_view'
FeedPostView = require 'views/feed/feed_post_view'

module.exports = class FeedPostsView extends PostsView
  itemView: FeedPostView
