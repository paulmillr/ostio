PostsView = require 'views/post/posts-view'
FeedPostView = require 'views/feed/feed-post-view'

module.exports = class FeedPostsView extends PostsView
  itemView: FeedPostView
