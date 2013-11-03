CollectionView = require 'views/base/collection-view'

module.exports = class PostsView extends CollectionView
  className: 'topic-posts'
  itemView: require 'views/post/post-view'
  listen:
    'post:new mediator': 'push'

  push: (post) ->
    @collection.push post
