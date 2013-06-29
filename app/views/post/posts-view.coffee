CollectionView = require 'views/base/collection-view'
Post = require 'views/post/post-view'

module.exports = class PostsView extends CollectionView
  className: 'topic-posts'
  itemView: Post
  listen:
    'post:new mediator': 'push'

  push: (post) =>
    @collection.push post
