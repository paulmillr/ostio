CollectionView = require 'chaplin/views/collection_view'
Post = require 'views/post_view'

module.exports = class PostsView extends CollectionView
  className: 'topic-posts'

  getView: (item) ->
    new Post model: item
