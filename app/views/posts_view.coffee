CollectionView = require 'views/base/collection_view'
Post = require 'views/post_view'

module.exports = class PostsView extends CollectionView
  className: 'topic-posts'

  itemView: Post
